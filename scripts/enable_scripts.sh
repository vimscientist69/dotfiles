echo "Starting random wallpaper daemon"
ls -s "$HOME"/.config/scripts/random_wallpaper/random_wallpaper.plist "$HOME"/Library/LaunchAgents/random_wallpaper.plist

launchctl start random_wallpaper
