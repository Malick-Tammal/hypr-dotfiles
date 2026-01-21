import { Gdk } from "ags/gtk4"

function PowerBtn() {
    return (
        <box class="power-btn">
            <button cursor={Gdk.Cursor.new_from_name("pointer", null)}>
                <label label="" />
            </button>
        </box>
    )
}

export default PowerBtn
