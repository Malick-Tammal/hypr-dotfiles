import { Astal, Gtk, Gdk } from "ags/gtk4";
import app from "ags/gtk4/app";
import Workspaces from "./Workspaces";
import Clock from "./Clock";
import WifiBtn from "./buttons/WifiBtn";
import PowerBtn from "./buttons/PowerBtn";
import NotificationBtn from "./buttons/NotificationBtn";
import { createBinding, For } from "ags"

function Bar({ gdkmonitor: monitor }: { gdkmonitor: Gdk.Monitor }) {

    const { TOP, LEFT, RIGHT } = Astal.WindowAnchor

    return (
        <window
            visible
            name={`bar-${monitor}`}
            class="bar"
            namespace="my-bar"
            application={app}
            anchor={TOP | LEFT | RIGHT}
            exclusivity={Astal.Exclusivity.EXCLUSIVE}
            gdkmonitor={monitor}
        >
            <centerbox orientation={Gtk.Orientation.HORIZONTAL}>

                {
                    //  INFO: Left Box
                }
                <box $type="start" class="left" spacing={10}>
                    <NotificationBtn />
                    <Clock />
                </box>

                {
                    //  INFO: Center Box
                }
                <box
                    $type="center"
                    class="center"
                    hexpand={false}
                    halign={Gtk.Align.CENTER}
                >
                    <Workspaces />
                </box>

                {
                    //  INFO: Right Box
                }
                <box $type="end" class="right">
                    <WifiBtn />
                    <PowerBtn />
                </box>
            </centerbox>
        </window >
    );
}

function MonitorSetup({ monitor }: { monitor: Gdk.Monitor }) {
    const bar = <Bar gdkmonitor={monitor} />;
    return bar;
}

export default function() {
    const monitors = createBinding(app, "monitors");
    return (
        <For each={monitors} cleanup={(win) => (win as Gtk.Window).destroy()}>
            {(monitor) => <MonitorSetup monitor={monitor} />}
        </For>
    );
}
