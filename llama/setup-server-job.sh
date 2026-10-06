#!/bin/sh

echo "Configuring llama-server launch agent..."

PLIST_DEST="$HOME/Library/LaunchAgents/com.user.llama-server.plist"
LLAMA_SERVER="$(command -v llama-server || echo /opt/homebrew/bin/llama-server)"

cat << EOF > "$PLIST_DEST"
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>Label</key>
    <string>com.user.llama-server</string>
    <key>ProgramArguments</key>
    <array>
        <string>$LLAMA_SERVER</string>
        <string>--fim-qwen-3b-default</string>
        <string>--host</string>
        <string>127.0.0.1</string>
        <string>--port</string>
        <string>8012</string>
    </array>
    <key>RunAtLoad</key>
    <true/>
    <key>KeepAlive</key>
    <true/>
    <key>StandardOutPath</key>
    <string>/tmp/llama-server.log</string>
    <key>StandardErrorPath</key>
    <string>/tmp/llama-server.err</string>
</dict>
</plist>
EOF

chmod 644 "$PLIST_DEST"

launchctl unload "$PLIST_DEST" >/dev/null 2>&1
launchctl load -w "$PLIST_DEST"

echo "llama-server agent registered on 127.0.0.1:8012."
