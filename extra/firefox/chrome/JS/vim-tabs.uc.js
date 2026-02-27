(function () {
  if (location.href !== "chrome://browser/content/browser.xhtml") return;

  function initCustomKeys() {
    let keyset = document.getElementById("mainKeyset");
    if (!keyset) return;

    // Remove conflicting native shortcuts
    let existingKeys = keyset.getElementsByTagName("key");
    for (let key of existingKeys) {
      let modifiers = key.getAttribute("modifiers");
      let keyAttr = key.getAttribute("key");

      if (modifiers === "alt" && keyAttr) {
        let k = keyAttr.toLowerCase();
        if (["h", "l", "n", "q", "u", "d", "i", "o", "e", "r"].includes(k)) {
          key.removeAttribute("key");
          key.removeAttribute("modifiers");
        }
      }
    }

    // Updated helper function to accept proper JS callbacks
    function addShortcut(id, modifiers, keyStr, commandString, callbackFn) {
      let oldKey = document.getElementById(id);
      if (oldKey) oldKey.remove();

      let newKey = document.createXULElement("key");
      newKey.id = id;
      newKey.setAttribute("modifiers", modifiers);
      newKey.setAttribute("key", keyStr);

      if (commandString) {
        newKey.setAttribute("command", commandString);
      } else if (callbackFn) {
        newKey.addEventListener("command", callbackFn, false);
      }

      keyset.appendChild(newKey);
    }

    // Core Tab Navigation
    addShortcut("vim-prev-tab", "alt", "H", null, (e) =>
      gBrowser.tabContainer.advanceSelectedTab(-1, true),
    );
    addShortcut("vim-next-tab", "alt", "L", null, (e) =>
      gBrowser.tabContainer.advanceSelectedTab(1, true),
    );
    addShortcut("vim-new-tab", "alt", "N", "cmd_newNavigatorTab", null);
    addShortcut("vim-close-tab", "alt", "Q", "cmd_close", null);
    addShortcut("vim-undo-tab", "alt", "U", "History:UndoCloseTab", null);

    // Advanced Window Manager Binds
    // Move Tab Left/Right
    addShortcut("vim-move-tab-left", "alt,shift", "H", null, (e) =>
      gBrowser.moveTabBackward(),
    );
    addShortcut("vim-move-tab-right", "alt,shift", "L", null, (e) =>
      gBrowser.moveTabForward(),
    );

    // Toggle Pin Status
    addShortcut("vim-pin-tab", "alt", "P", null, (e) => {
      let tab = gBrowser.selectedTab;
      tab.pinned ? gBrowser.unpinTab(tab) : gBrowser.pinTab(tab);
    });

    // Toggle Tab Audio Mute
    addShortcut("vim-mute-tab", "alt", "M", null, (e) =>
      gBrowser.selectedTab.toggleMuteAudio(),
    );

    // Toggle Download popup
    addShortcut("vim-downloads-popup", "alt", "D", null, (e) => {
      DownloadsPanel.showDownloadsHistory();
    });

    // Inspector / DevTools (Alt + I)
    addShortcut("vim-inspector", "alt", "I", null, (e) => {
      document.getElementById("key_inspector").doCommand();
    });

    // Focus Address Bar (Alt + O)
    addShortcut("vim-focus-url", "alt", "O", null, (e) => {
      gURLBar.focus();
      gURLBar.select();
    });

    // Open Extensions/Add-ons Manager (Alt + E)
    addShortcut("vim-addons", "alt", "E", "Tools:Addons", null);
  }

  if (gBrowserInit.delayedStartupFinished) {
    initCustomKeys();
  } else {
    let observer = (subject, topic, data) => {
      if (topic === "browser-delayed-startup-finished" && subject === window) {
        Services.obs.removeObserver(observer, topic);
        initCustomKeys();
      }
    };
    Services.obs.addObserver(observer, "browser-delayed-startup-finished");
  }
})();
