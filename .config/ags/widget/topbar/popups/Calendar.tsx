import { Gtk, Gdk, Astal } from "ags/gtk4";

const Calendar = ({ gdkmonitor: monitor }: { gdkmonitor: Gdk.Monitor }) => {
    const { TOP, BOTTOM, LEFT, RIGHT } = Astal.WindowAnchor;

    const win = (
        <window
            visible={false}
            gdkmonitor={monitor}
            name="calendar-popup"
            namespace="calendar-popup"
            anchor={TOP | BOTTOM | LEFT | RIGHT}
            layer={Astal.Layer.TOP}
            exclusivity={Astal.Exclusivity.IGNORE}
            keymode={Astal.Keymode.ON_DEMAND}
            css="background-color: transparent;"
        >
            <box hexpand={true} vexpand={true} css="background-color: transparent;">
                <box halign={Gtk.Align.START} valign={Gtk.Align.START} marginTop={60} marginStart={10}>
                    <Gtk.Calendar class="calendar-popup" />
                </box>
            </box>
        </window>
    ) as Astal.Window;

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

    return win;
};

export default Calendar;
