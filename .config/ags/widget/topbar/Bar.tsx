import { Astal, Gtk, Gdk } from "ags/gtk4";
import app from "ags/gtk4/app";
import Workspaces from "./Workspaces";
import Clock from "./Clock";
import WifiBtn from "./buttons/WifiBtn";
import PowerBtn from "./buttons/PowerBtn";
import NotificationBtn from "./buttons/NotificationBtn";

export function Bar({ gdkmonitor: monitor }: { gdkmonitor: Gdk.Monitor }) {

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
