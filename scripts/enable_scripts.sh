echo "Starting random wallpaper daemon"
rm -rf "$HOME/Library/LaunchAgents/com.scripts.wallpaper.random.start.plist"
ln -s "$HOME/.config/scripts/random_wallpaper/com.scripts.wallpaper.random.start.plist" "$HOME/Library/LaunchAgents"

launchctl load "$HOME/Library/LaunchAgents/com.scripts.wallpaper.random.start.plist"
