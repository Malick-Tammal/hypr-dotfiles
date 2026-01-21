import { createState, createBinding, createEffect, For, With } from "ags"
import { Astal, Gtk, Gdk } from "ags/gtk4"
import { execAsync } from "ags/process"
import AstalNetwork from "gi://AstalNetwork?version=0.1"
import GLib from "gi://GLib?version=2.0"

//  INFO: Access point type
type AP = {
    ssid: string
    iconName: string
    strength: number
    bssid: string
    active: boolean
}

function Wifi({ gdkmonitor: monitor }: { gdkmonitor: Gdk.Monitor }) {

    // System network service
    const network = AstalNetwork.get_default()

    // List of networks
    const [list, setList] = createState<AP[]>([])

    // Wifi switch
    const [isWifiOn, setIsWifiOn] = createState(network.wifi?.enabled || false)

    // Heartbeat
    const [tick, setTick] = createState(0)

    // Create Listeners for the system properties
    const accessPointes = createBinding(network.wifi, "accessPoints")
    const wifiEnabled = createBinding(network.wifi, "enabled")

    const { TOP, LEFT, RIGHT, BOTTOM } = Astal.WindowAnchor

    // Start a timer that runs every 2 seconds (2000 ms)
    const sourceId = GLib.timeout_add(GLib.PRIORITY_DEFAULT, 2000, () => {
        setTick(t => t + 1)
        return true
    })

    // --- THE LOGIC LOOP ---
    createEffect(() => {
        // 1. Read Dependencies
        // calling these functions registers them as dependencies.
        const enabled = wifiEnabled()
        const aps = accessPointes()
        tick() // We call this so the effect re-runs when tick changes

        // Update local switch state
        setIsWifiOn(enabled)

        // 2. CRITICAL SAFETY CHECK
        // If Wi-Fi is disabled, we STOP immediately.
        // We do not try to read the list, preventing the crash.
        if (!enabled) {
            setList([])
            return
        }

        // SAFE CONVERSION
        try {
            // 1. Get the current active BSSID so we can mark it
            const activeAP = network.wifi.activeAccessPoint
            const activeBssid = activeAP ? activeAP.bssid : ""

            // map: Transform [Dangerous GObject] -> [Safe Object]
            const extracted = aps.map(ap => {
                try {
                    // If the object is somehow broken, skip it
                    if (!ap || !ap.ssid) return null

                    return {
                        ssid: ap.ssid,
                        iconName: ap.iconName || "network-wireless-signal-none-symbolic",
                        strength: ap.strength || 0, // This gets updated every tick!
                        bssid: ap.bssid || "",
                        active: activeBssid === ap.bssid
                    }
                } catch (e) {
                    return null // If a crash happens here, we catch it silently
                }
            })

            // 4. Filter & Sort
            const cleanList = extracted
                .filter((item): item is AP => item !== null)
                .sort((a, b) => {
                    // Priority 1: Connected network always first
                    if (a.active) return -1
                    if (b.active) return 1

                    // Priority 2: Strength (Strongest first)
                    const strengthDiff = b.strength - a.strength
                    if (strengthDiff !== 0) return strengthDiff

                    // Priority 3: Alphabetical (A-Z)
                    return a.ssid.localeCompare(b.ssid)
                })

            // Update the UI list
            setList(cleanList)
        } catch (error) {
            setList([])
        }
    })

    // Connect function
    const connect = (bssid: string, ssid: string) => {
        print(`Connecting to ${ssid}...`)
        // We use nmcli command line because it's safer than GObject methods
        execAsync(`nmcli device wifi connect ${bssid}`)
            .catch(err => print(err))
    }

    const win = (
        <window
            visible={false}
            gdkmonitor={monitor}
            name="wifi-popup"
            namespace="wifi-popup"
            onDestroy={() => GLib.source_remove(sourceId)}
            anchor={TOP | BOTTOM | LEFT | RIGHT}
            layer={Astal.Layer.TOP}
            exclusivity={Astal.Exclusivity.IGNORE}
            keymode={Astal.Keymode.ON_DEMAND}
            css="background-color: transparent;"
        >
            <box hexpand={true} vexpand={true} css="background-color: transparent;">
                <box halign={Gtk.Align.END} valign={Gtk.Align.START} marginTop={60} marginEnd={10} class="wifi-menu" orientation={Gtk.Orientation.VERTICAL}>
                    {
                        // Header
                    }
                    <box class="header">
                        <label label="Available networks" css="font-weight: bold;" />
                        <box hexpand />
                        <switch
                            active={isWifiOn()}
                            onNotifyActive={(self) => {
                                // If turning off, clear list INSTANTLY to look responsive
                                if (!self.active) setList([])
                                // Then tell the system to actually switch
                                network.wifi.set_enabled(self.active)
                            }}
                        />
                    </box>

                    <Gtk.Separator />

                    {/* --- BODY --- */}
                    <box orientation={Gtk.Orientation.VERTICAL} class="body">
                        <With value={isWifiOn}>
                            {(enabled) => {
                                // CASE 1: Wifi is Off
                                if (!enabled) {
                                    return <label label="Wi-Fi is Disabled" />
                                }

                                // CASE 2: Wifi is On
                                return (
                                    <Gtk.ScrolledWindow
                                        propagateNaturalHeight={true}
                                        maxContentHeight={300}
                                        min_content_height={100}
                                        hscrollbarPolicy={Gtk.PolicyType.NEVER}
                                        vscrollbarPolicy={Gtk.PolicyType.AUTOMATIC}
                                    >
                                        <box orientation={Gtk.Orientation.VERTICAL}>
                                            <For each={list}>
                                                {(ap: AP) => (
                                                    <button
                                                        onClicked={() => {
                                                            console.log(ap.ssid)
                                                            connect(ap.bssid, ap.ssid)
                                                        }}
                                                        cssClasses={ap.active ? ["wifi", "connected"] : ["wifi"]}
                                                    >
                                                        <box spacing={12}>
                                                            <image iconName={ap.iconName} />
                                                            <label label={ap.ssid} hexpand xalign={0} />
                                                            <label label={`${ap.strength}%`} />
                                                        </box>
                                                    </button>
                                                )}
                                            </For>
                                        </box>
                                    </Gtk.ScrolledWindow>
                                )
                            }}
                        </With>
                    </box>
                </box>
            </box>
        </window >
    ) as Astal.Window

    // --------------------------------------------------------------------
    //  INFO: Close the calendar when clicking outside or pressing Escape
    // --------------------------------------------------------------------

    const backgroundBox = win.get_child() as Gtk.Box;
    const contentBox = backgroundBox.get_first_child() as Gtk.Box;

    const bgClick = new Gtk.GestureClick();

    bgClick.connect("pressed", (_, n, x, y) => {
        const alloc = contentBox.get_allocation();

        const insideX = x >= alloc.x && x <= alloc.x + alloc.width;
        const insideY = y >= alloc.y && y <= alloc.y + alloc.height;

        if (!insideX || !insideY) {
            win.visible = false;
        }
    });

    backgroundBox.add_controller(bgClick);

    const keyController = new Gtk.EventControllerKey();
    keyController.connect("key-pressed", (_, keyval) => {
        if (keyval === Gdk.KEY_Escape) {
            win.visible = false;
        }
    });
    win.add_controller(keyController);

    return win

}

export default Wifi
