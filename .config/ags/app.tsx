import { createBinding, For, This } from "ags"
import app from "ags/gtk4/app"
import style from "./assets/style.scss"
// import TopBar from "./widget/TopBar"
import { Bar } from "./widget/topbar/Bar"
import Wifi from "./widget/topbar/popups/WifiMenu"
import Calendar from "./widget/topbar/popups/Calendar"

app.start({
    css: style,
    main() {
        const monitors = createBinding(app, "monitors")

        return (
            <For each={monitors} >
                {(monitor) => (
                    <This this={app} >
                        {
                            <Bar gdkmonitor={monitor} />
                        }
                        {
                            <Wifi gdkmonitor={monitor} />
                        }

                        {
                            // <TopBar gdkmonitor={monitor} />
                            <Calendar gdkmonitor={monitor} />
                        }
                    </This>

                )}
            </For>
        )
    },


    requestHandler(request: string[], res: (response: any) => void) {
        const command = request[0]

        if (command === "wifi") {
            const win = app.get_window("wifi-popup")

            if (win) {
                // Toggle visibility
                win.visible = !win.visible
                res(`wifi window is now ${win.visible ? "visible" : "hidden"}`)
            } else {
                res("error: window not found")
            }
        }


        if (command === "calendar") {
            const win = app.get_window("calendar-popup")

            if (win) {
                // Toggle visibility
                win.visible = !win.visible
                res(`wifi window is now ${win.visible ? "visible" : "hidden"}`)
            } else {
                res("error: window not found")
            }
        }
    }
})
