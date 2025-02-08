#!/usr/bin/env bash

hydeScrDir="$(dirname "$(realpath "$(which wallpaper.sh)")")"
cliTool=$1

# shellcheck disable=SC1091
source "${hydeScrDir}/globalcontrol.sh"

if pkg_installed $cliTool; then
        term=$(grep -E '^\s*'"$term" "$HOME/.config/hypr/keybindings.conf" | cut -d '=' -f2 | xargs) # dumb search the config
        term=${TERMINAL:-$term}                                                                      # Use env var
        term=${SYSMONITOR_TERMINAL:-$term}                                                           # use the declared variable
	pkill -x $cliTool || $term $cliTool &
fi
