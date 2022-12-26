LOG_FILE=./c.log
SCRIPT_PATH="./call_clerkie.py"

setup_capture_hook() {
    exec 2> >(tee $LOG_FILE)
    echo "Clerkie On."
}

setup_capture_hook

precmd() {
    STATUS=$?
    if [[ $STATUS -ne 0 && $STATUS -ne 130 ]]; then
        python3 "$SCRIPT_PATH" debug_terminal
    fi
}
