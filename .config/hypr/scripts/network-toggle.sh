#!/bin/sh
# If it's already running, kill it (Toggle Off)
if pgrep -f "nmgui" >/dev/null; then
    pkill -f "nmgui"
else
    # If not running, start it (Toggle On)
    nmgui &
fi
