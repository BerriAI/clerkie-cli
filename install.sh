set -e

echo "Starting clerkie-cli install"

python3 -m pip install requests
python3 -m pip install rich

echo "Done pip installs"

main() {
    CLERKIE_DIR=$HOME/.clerkie-cli
    START=$PWD
    mkdir -p $CLERKIE_DIR
    cd $CLERKIE_DIR

    RELEASE_URL="https://github.com/ishaan-jaff/clerkie-cli/archive/refs/tags/v0.0.2-beta.zip"
    echo "$RELEASE_URL"

    echo "downloading latest release in $CLERKIE_DIR"
    ensure curl -L "$RELEASE_URL" -o $CLERKIE_DIR/release.zip
    chmod +x $CLERKIE_DIR/release.zip
    unzip -q -o $CLERKIE_DIR/release.zip
    rm $CLERKIE_DIR/release.zip
    echo "installed clerkie and unzipped"

    FOLDER_NAME=$(ls -d */ | head -n 1)
    if [ -d "$FOLDER_NAME" ]; then
      echo "renaming $FOLDER_NAME"
      mv "$FOLDER_NAME" "clerkie-src"
    else
      echo "Error: No folder found in the current working directory."
    fi

    if [[ -n $ZSH_VERSION ]]; then
       PROFILE=$HOME/.zshrc

    elif [[ -n $BASH_VERSION ]]; then
      PROFILE=$HOME/.bashrc

    elif [[ -n $FISH_VERSION ]]; then
      PROFILE=$HOME/.config/fish/config.fish

    elif [[ -n $ASH_VERSION ]]; then
      PROFILE=$HOME/.profile

    echo "# clerkie-cli configs" >>$HOME/.zshrc
    echo "export CLERKIE_SRC=$CLERKIE_DIR/clerkie-src" >>$PROFILE
    echo '[[ -f "$HOME/.clerkie-cli/clerkie-src/setup.sh" ]] && builtin source "$HOME/.clerkie-cli/clerkie-src/setup.sh"' >>$PROFILE
    echo "Clerkie Installed. Open a new Terminal Window to start using"
    cd $START
}

ensure() {
  if ! "$@"; then err "command failed: $*"; fi
}

main "$@" || exit 1


