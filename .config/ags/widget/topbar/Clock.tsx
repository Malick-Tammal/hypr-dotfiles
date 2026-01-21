import { Gdk } from "ags/gtk4";
import app from "ags/gtk4/app";
import { createPoll } from "ags/time";

const Clock = () => {
    const minutes = createPoll(
        "",
        1000,
        () =>
            new Date().toLocaleTimeString(undefined, {
                minute: "2-digit"
            })
    )

    const hours = createPoll(
        "",
        1000,
        () =>
            new Date().toLocaleTimeString(undefined, {
                hour: "2-digit"
            }).replace(/(AM|PM)/g, "").trim()
    )

    const timeFormat = createPoll(
        "",
        1000,
        () => {
            let format: string = new Date().toLocaleTimeString(undefined, {
                hour: "2-digit"
            }).replace(/[^A-Z]/g, "")
            return format
        }
    )

    return (
        <box class="clock">
            <button
                cursor={Gdk.Cursor.new_from_name("pointer", null)}
                onClicked={() => {
                    const win = app.get_window("calendar-popup")
                    if (win) win.visible = !win.visible
                }}
            >
                <box>
                    <label class="hours" label={hours} />
                    <label label=":" />
                    <label class="minutes" label={minutes} />
                    <label label=" " />
                    <label class="time-format" label={timeFormat} />
                </box>
            </button>
        </box>
    )
}

export default Clock
