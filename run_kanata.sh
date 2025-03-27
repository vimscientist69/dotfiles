#!/bin/bash

# Variables
KANATA_SCRIPT="/usr/local/bin/wait_for_karabiner.sh"
KANATA_PATH="/Users/williamferns/.local/bin/kanata_macos_arm64"
KARABINER_VIRTUALHIDDEVICE_DAEMON="/Library/Application Support/org.pqrs/Karabiner-DriverKit-VirtualHIDDevice/Applications/Karabiner-VirtualHIDDevice-Daemon.app/Contents/MacOS/Karabiner-VirtualHIDDevice-Daemon"
SUDOERS_FILE="/etc/sudoers.d/kanata"
PLIST_FILE="/Library/LaunchDaemons/com.williamferns.kanata.plist"
KARABINER_PLIST_FILE="/Library/LaunchDaemons/com.williamferns.karabiner_virtualhiddevice_daemon.plist"

sudo launchctl remove com.williamferns.kanata
sudo launchctl remove com.williamferns.karabiner_virtualhiddevice_daemon

sudo rm -rf $KANATA_SCRIPT $PLIST_FILE $KARABINER_PLIST_FILE $SUDOERS_FILE
sudo cp ./wait_for_karabiner.sh $KANATA_SCRIPT
sudo chmod +x $KANATA_SCRIPT

# Create a sudoers file entry for kanata
echo "$(whoami) ALL=(ALL) NOPASSWD: $KANATA_PATH, $KARABINER_VIRTUALHIDDEVICE_DAEMON" | sudo tee "$SUDOERS_FILE" >/dev/null

# Create a plist file for the Kanata LaunchDaemon
cat <<EOF | sudo tee "$PLIST_FILE" >/dev/null
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>Label</key>
    <string>com.williamferns.kanata</string>

    <key>ProgramArguments</key>
    <array>
        <string>$KANATA_SCRIPT</string>
    </array>

    <key>RunAtLoad</key>
    <true/>

    <key>KeepAlive</key>
    <dict>
        <key>OtherJobEnabled</key>
        <string>com.williamferns.karabiner_virtualhiddevice_daemon</string>
    </dict>

    <key>StandardErrorPath</key>
    <string>/var/log/kanata.error.log</string>

    <key>StandardOutPath</key>
    <string>/var/log/kanata.output.log</string>
</dict>
</plist>
EOF

# Create a plist file for the Karabiner VirtualHIDDevice Daemon LaunchDaemon
cat <<EOF | sudo tee "$KARABINER_PLIST_FILE" >/dev/null
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>Label</key>
    <string>com.williamferns.karabiner_virtualhiddevice_daemon</string>

    <key>ProgramArguments</key>
    <array>
        <string>$KARABINER_VIRTUALHIDDEVICE_DAEMON</string>
    </array>

    <key>RunAtLoad</key>
    <true/>

    <key>KeepAlive</key>
    <true/>

    <key>StandardErrorPath</key>
    <string>/var/log/karabiner_virtualhiddevice_daemon.error.log</string>

    <key>StandardOutPath</key>
    <string>/var/log/karabiner_virtualhiddevice_daemon.output.log</string>
</dict>
</plist>
EOF

sudo launchctl load -w "$KARABINER_PLIST_FILE"
sudo launchctl load -w "$PLIST_FILE"
