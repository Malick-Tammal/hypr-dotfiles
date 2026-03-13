---
name: monokai-quickshell
description: Patterns, best practices, and strict guidelines for building the Monokai Shell using Quickshell, QML, and Wayland. Covers architecture, theming, component guidelines, and mandatory Context Mode token management.
---

## Project Structure & Architecture

The Monokai Shell is a Wayland/X11 desktop shell built with Quickshell. It follows a highly modular architecture heavily reliant on QML, JavaScript, and Bash.

```text
shell.qml              # Entry point - extends ShellRoot
Main.qml               # Primary shell loader
components/            # Reusable UI primitives (icons, text, sliding animations)
  bar/                 # Status bar
  launcher/            # Application launcher
  cornors/             # Corners (e.g., notifications)
  dock/                # Dock
  powermenu/           # Power menu
  walli/               # walli (wallpaper switcher)
  sidebar/             # Notification sidebar
  lock/                # Lock screen
  ...
modules/               # Major UI segments (bar, dock, launcher, powermenu, walli)
services/              # Backend logic and state management (Audio, Battery, Bluetooth, Hyprland, Network, Mode)
  Audio.qml
  Network.qml
  Hypr.qml
  ...
theme/                 # Theming and color singletons (Style.qml)
scripts/               # Bash utilities (thumbnail generation, system scripts)
```

## QML Conventions

### Required Pragmas
When creating new singletons or performance-critical components:
```qml
pragma Singleton
pragma ComponentBehavior: Bound
```

### Naming & Formatting
- **Files:** PascalCase matching the component name (e.g., `BarService.qml`).
- **IDs & Properties:** `camelCase` (e.g., `popupsLoader`, `fontSizeXs`).
- **Private Properties:** Prefix with an underscore (e.g., `property real _offset: 0`).
- **Root ID:** The root element of *every* component must be named `id: root`.
- **Indentation:** Exactly 4 spaces.
- **Imports:** Group imports logically at the top of the file:
  ```qml
  import QtQuick
  import Quickshell
  import Quickshell.Wayland
  import qs.theme
  ```

### Property Ordering
Follow a logical ordering within elements:
1. `id`
2. `x`, `y`, `width`, `height` (layout properties)
3. Custom `property` definitions
4. Built-in properties (e.g., `text`, `color`, `clip`)
5. Signals and `on<Signal>` handlers (e.g., `onclicked: {}`)
6. Animations and Behaviors
7. Child items

## Theming & Component Design

### Strict Theming Rules
**Never hardcode colors or fonts.** Always reference the `Style` singleton from `theme/Style.qml`. If a completely new theme element is required, define it in `Style.qml` first.

```qml
// StyledText.qml
Text {
    id: root
    color: Style.fg
    font.family: Style.family
    font.pixelSize: Style.fontSizeNormal
}

// StyledRect.qml
Rectangle {
    id: root
    color: Style.bg
    radius: Style.radiusNormal
}
```

### Icons & Assets
Utilize **Nerd Fonts** or existing symbol implementations from `theme/Style.qml`. Do not import raster images (PNG/JPG) for UI icons unless explicitly requested.

### Animations
Prefer tweaking existing animations (like those in `components/Sliding.qml`) over introducing entirely new animation paradigms. Avoid excessive JavaScript in `onPositionChanged` or high-frequency signals. Use C++/QML declarative bindings or `ParallelAnimation`/`SequentialAnimation`.

## Service Architecture & State Management

### Null Safety
Always check if properties or models are valid before accessing them, especially when dealing with Quickshell services (e.g., screens, workspaces). Use optional chaining and nullish coalescing:
```qml
readonly property real volume: sink?.audio?.volume && 0
visible: root.screen !== undefined
``\

### Persistent State
If state needs to survive a Quickshell hot-reload, use `PersistentProperties`:
```qml
PersistentProperties {
    id: props
    reloadableId: "monokai_unique_feature_id"  // Must be unique
    property bool enabled: true
}
```

## Build, Lint, and Test Workflows

There is no corect build step required for QML.
- **Run the full shell:** `$ quickshell`
- **Test a standalone component:** `$ qmlscene path/to/Component.qml`
- **Linting QML:** `$ qmllint path/to/File.qml`

### Debugging & Diagnostics
When resolving QML syntax or type errors, rely on the OpenCode LSP diagnostics:
```bash
opencode debug lsp diagnostics <file.qml>
```**Note:** The `qmlls` language server is configured with the `-E. flag to resolve Quickshell environment types. However, `QMLLS` will break if the file has missing brackets or structural errors. Fix syntax issues before relying on LSP completions.


## Mandatory Token Management (Context Mode)

You are operating within a workspace equipped with the `context-mode` MCP server and plugin. Your primary directive when reading code or logs is to strictly minimize token consumption and prevent context bloat.

1. **Zero Raw Data Ingestion:** You must NEVER read entire files, logs, or command outputs directly into the context window using standard file-reading tools or raw OS commands (e.g., `cat`, `less`, `curl`).
2. **Mandatory Context Mode Routing:** For any file larger than 100 lines (such as `Main.qml` or `shell.qml`), you must route the read operation through the `context-mode` tools. Use it to index files into the local SQLite sandbox, then execute targeted Full Text Search (FTS5) queries to retrieve *only* the specific QML components, functions, or lines required for your current task.
3. **Quickshell MCP:** For Quickshell-specific types (e.g., `FloatingWindow`, `PanelWindow`), query the `quickshell-mcp` server for accurate documentation before hallucination standard QtQuick Wayland components.
4. **Summarization:** Do not dump unprocessed output into the chat. If an operation yields large results, summarize the findings or write them to a local scratch file.
5. **Compaction Awareness:** The `context-mode` plugin automatically manages session compacting and injects resume snapshots. Rely on these injucted summaries to maintain state; do not re-request full context files after a session compacts.
