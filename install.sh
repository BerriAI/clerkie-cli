set -e

echo "Starting clerkie-cli install"

python3 -m pip install requests
python3 -m pip install rich

echo "Done pip installs"

read_email() {
  valid=0
  while [ $valid -eq 0 ]; do
    tput setaf 2
    echo "Please enter your email address:"
    tput sgr0
    read email
    if [[ $email =~ ^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$ ]]; then
      valid=1
      echo "Thank you. The email address $email is valid."
      echo "$email" >>$HOME/.clerkie-cli/clerkie-src/clerkie.txt
    else
      echo "Error: The email address $email is not valid. Please try again."
    fi
  done
}

get_latest_release() {
  REPO_OWNER="ishaan-jaff"
  REPO_NAME="clerkie-cli"
  local RELEASE_INFO=$(curl -s https://api.github.com/repos/$REPO_OWNER/$REPO_NAME/releases/latest)
  local RELEASE_URL=$(echo "$RELEASE_INFO" | grep '"zipball_url":' | sed -E 's/.*"([^"]+)".*/\1/')
  echo "$RELEASE_URL"
}



main() {
    CLERKIE_DIR=$HOME/.clerkie-cli
    START=$PWD
    rm -rf $CLERKIE_DIR
    mkdir -p $CLERKIE_DIR
    cd $CLERKIE_DIR

    RELEASE_URL=$(get_latest_release)
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

    echo "# clerkie-cli configs" >>$HOME/.zshrc
    read_email
    echo "export CLERKIE_SRC=$CLERKIE_DIR/clerkie-src" >>$HOME/.zshrc
    echo '[[ -f "$HOME/.clerkie-cli/clerkie-src/setup.sh" ]] && builtin source "$HOME/.clerkie-cli/clerkie-src/setup.sh"' >>$HOME/.zshrc
    echo "Clerkie Installed. Open a new Terminal Window to start using"
    cd $START
}

ensure() {
  if ! "$@"; then err "command failed: $*"; fi
}

main "$@" || exit 1
