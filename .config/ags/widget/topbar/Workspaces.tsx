import { Gdk } from "ags/gtk4"
import { createBinding, For } from "ags"
import Hyprland from "gi://AstalHyprland?version=0.1"

const Workspaces = () => {
    const hypr = Hyprland.get_default()
    const focused = createBinding(hypr, "focusedWorkspace")

    const staticRange = [1, 2, 3, 4, 5, 6, 7]
    const lastRange = staticRange[staticRange.length - 1]

    //  INFO: DYNAMIC: Only listen for workspaces > lastRange
    const dynamicRange = createBinding(hypr, "workspaces").as(wss => {
        return wss
            .map(w => w.id)
            .filter(id => id > lastRange)
            .sort((a, b) => a - b)
    })

    //  INFO: Workspace button
    const renderButton = (id: number) => (
        <button
            onClicked={() => hypr.dispatch("workspace", String(id))}
            cursor={Gdk.Cursor.new_from_name("pointer", null)}
            cssClasses={focused.as(fw => {
                const classes = ["workspace-btn"]
                if (fw.id === id) classes.push("focused")
                if (hypr.get_workspace(id)?.clients.length > 0) classes.push("occupied")
                return classes
            })}
        >
            <label label={focused.as(fw => {
                if (fw.id !== id) return String(id)

                const inRange = id <= lastRange
                const hasWindows = fw.clients.length > 0

                if (inRange || hasWindows) return "󰫢"

                return String(id)
            })} />
        </button>
    )

    return (
        <box class="workspaces" spacing={12}>
            {
                //  INFO: Static range render (the defined range)
            }

            {staticRange.map(id => renderButton(id))}

            {
                //  INFO: Dynamic range render (more then workspaces list) 
            }

            <For each={dynamicRange}>
                {(id) => renderButton(id)}
            </For>
        </box>
    )
}

export default Workspaces
