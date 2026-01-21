import { Gdk } from "ags/gtk4"
import { execAsync } from "ags/process"

function NotificationBtn() {
    return (
        <box class="notification">
            <button
                onClicked={() => execAsync("swaync-client -t -sw")}
                cursor={Gdk.Cursor.new_from_name("pointer", null)}
            >
                <label label="" />
            </button>
        </box>
    )
}

export default NotificationBtn
