#!/bin/sh

echo "Configuring weekly background Homebrew cleanup..."

PLIST_DEST="$HOME/Library/LaunchAgents/com.user.brew-cleanup.plist"
SCRIPT_PATH="$HOME/.dotfiles/homebrew/cleanup.sh"

# 1. Generate the plist dynamically using the correct home path
cat << EOF > "$PLIST_DEST"
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>Label</key>
    <string>com.user.brew-cleanup</string>
    <key>ProgramArguments</key>
    <array>
        <string>/bin/zsh</string>
        <string>$SCRIPT_PATH</string>
    </array>
    <key>StartInterval</key>
    <integer>604800</integer>
    <key>RunAtLoad</key>
    <true/>
    <key>StandardOutPath</key>
    <string>/tmp/brew-cleanup.log</string>
    <key>StandardErrorPath</key>
    <string>/tmp/brew-cleanup.err</string>
</dict>
</plist>
EOF

# 2. Set strict permissions required by launchd
chmod 644 "$PLIST_DEST"

# 3. Unload first (in case it already exists), then load the agent
launchctl unload "$PLIST_DEST" &>/dev/null
launchctl load -w "$PLIST_DEST"

echo "Weekly Homebrew cleanup daemon registered successfully."
