LOG_FILE="$CLERKIE_SRC/c.log"
SCRIPT_PATH="$CLERKIE_SRC/call_clerkie.py"

setup_capture_hook() {
    exec 2> >(tee "$LOG_FILE")
    echo "Clerkie Activated."
}

setup_capture_hook

precmd() {
    STATUS=$?
    if [[ $STATUS -ne 0 && $STATUS -ne 130 ]]; then
        python3 "$SCRIPT_PATH" debug_terminal
    fi
}
