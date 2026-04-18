#!/bin/bash
# Hook script for Claude Code SessionStart event
# Shows welcome message and Warp detection status

# Check if running in Warp terminal
if [ "$TERM_PROGRAM" = "WarpTerminal" ]; then
    # Running in Warp - notifications will work
    cat << 'EOF'
{
  "systemMessage": "🔔 Warp plugin active. You'll receive native Warp notifications when tasks complete or input is needed."
}
EOF
else
    # Not running in Warp - suggest installing
    cat << 'EOF'
{
  "systemMessage": "ℹ️ Warp plugin installed but you're not running in Warp terminal. Install Warp (https://warp.dev) to get native notifications when Claude completes tasks or needs input."
}
EOF
fi
