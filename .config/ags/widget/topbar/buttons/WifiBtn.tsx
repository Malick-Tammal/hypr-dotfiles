import { createBinding, With, createState, createEffect } from "ags"
import { Gdk } from "ags/gtk4"
import app from "ags/gtk4/app"
import AstalNetwork from "gi://AstalNetwork?version=0.1"


function WifiBtn() {
    const network = AstalNetwork.get_default()
    const wifi = createBinding(network, "wifi")

    const [label, setLabel] = createState("Disabled")
    const [icon, setIcon] = createState("network-wireless-disabled-symbolic")

    const bindEnabled = createBinding(network.wifi, "enabled")
    const bindSsid = createBinding(network.wifi, "ssid")
    const bindIcon = createBinding(network.wifi, "iconName")

    createEffect(() => {
        const isOn = bindEnabled()
        const currentSsid = bindSsid()
        const currentIcon = bindIcon()

        // CASE 1: Wi-Fi is OFF
        if (!isOn) {
            setLabel("Disabled")
            setIcon("network-wireless-disabled-symbolic")
            return
        }

        // CASE 2: Wi-Fi is ON, but not connected
        if (!currentSsid) {
            setLabel("Disconnected")
            setIcon("network-wireless-offline-symbolic")
            return
        }

        // CASE 3: Connected
        setLabel(currentSsid)
        setIcon(currentIcon)
    })

    return (
        <box class="wifi-btn" visible={wifi(Boolean)}>
            <With value={wifi}>
                {(wifi) =>
                    wifi && (
                        <button
                            cursor={Gdk.Cursor.new_from_name("pointer", null)}
                            onClicked={() => {
                                const win = app.get_window("wifi-popup")
                                if (win) win.visible = !win.visible
                            }}
                        >
                            <box spacing={5}>
                                <image iconName={icon()} />
                                <label label={label()} />
                            </box>
                        </button>
                    )
                }
            </With>
        </box>
    )
}

export default WifiBtn
