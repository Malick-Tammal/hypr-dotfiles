import app from "ags/gtk4/app"
import { exec } from "ags/process";
import Bar from "./widget/topbar/Bar"
import Wifi from "./widget/topbar/popups/WifiMenu"
import Calendar from "./widget/topbar/popups/Calendar"
import { Gdk } from "ags/gtk4";

const css = './assets/style.css'
const scss = './assets/style.scss'

function reloadCss() {
    console.log("scss change detected - recompiling...");
    exec(`sass ${scss} ${css}`);
    app.apply_css(css);
}

app.start({
    css: css,
    instanceName: "monokai-shell",
    main() {
        reloadCss()
        const display = Gdk.Display.get_default();
        const monitors = display?.get_monitors();
        const count = monitors?.get_n_items() || 0;
        const mainMonitor = monitors?.get_item(0) as Gdk.Monitor;

        Bar()

        if (mainMonitor) {
            // Only create ONE instance of these, on the primary screen
            Wifi({ gdkmonitor: mainMonitor });
            // Calendar({ gdkmonitor: mainMonitor }); // Uncomment if you want Calendar too
        }
    },
    requestHandler(argv: string[], res: (response: any) => void) {
        const request = argv[0]
        switch (request) {
            case "wifi": {
                const win = app.get_window("wifi-popup")
                console.log(win)

                if (win) {
                    // Toggle visibility
                    win.visible = !win.visible
                    res(`wifi window is now ${win.visible ? "visible" : "hidden"}`)
                } else {
                    res("error: window not found")
                }
                break
            }
            case "calendar": {
                const win = app.get_window("calendar-popup")

                if (win) {
                    // Toggle visibility
                    win.visible = !win.visible
                    res(`calendar window is now ${win.visible ? "visible" : "hidden"}`)
                } else {
                    res("error: window not found")
                }
                break
            }
            default:
                res(`Unknown command: ${request}`)
        }
    }
})
