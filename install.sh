#!/bin/sh

source ".env"

## Requires:
# - `espanso`
# - `python3`
# - 'zsh' or `bash`

# TODO: uninstall flag?

# Check if an argument for branch is provided
if [ $# -eq 1 ]; then
  BRANCH=$1
fi

echo "Checking whether Espanso is installed..."
if command -v espanso > /dev/null; then
    echo "Espanso is installed"
else
    echo "Error: Espanso is not installed"
    exit 1
fi

echo "Checking whether Python 3 is installed..."
if command -v python3 > /dev/null; then
    echo "Python 3 is installed"
else
    echo "Error: Python 3 is not installed"
    exit 1
fi

# both espanso and python3 should be installed now
echo "espanso and python3 are installed"

# Install python dependencies
pip3 install -r "requirements.txt"

# Check if the current shell is zsh
if [ -n "$ZSH_VERSION" ]; then
    echo "Detected zsh shell"
    RC_FILE="$HOME/.zshrc"
# Otherwise, assume it's bash
else
    echo "Detected bash shell"
    RC_FILE="$HOME/.bashrc"
fi
# Add ESPANSO_CONFIG_PATH to bashrc/zshrc file if it wasn't already added
grep -qF -- "$RC_LINE" "$RC_FILE" || echo "$RC_LINE" >> "$RC_FILE"

# Create the installation folder in the home directory
mkdir "$INSTALL_FOLDER"

# TODO: maybe add reinstall flag so config.ini doesn't get overwritten unless user wants to.

# Create an Espanso package called openai
mkdir "$ESPANSO_FILE_CONFIG_PATH/match/packages/$PACKAGE_NAME"

# Files to download
SCRIPT_FILE="openai_chatgpt.py"
ESPANSO_FILE="package.yml"
SOUND_FILE="bell.wav"

# destination directory
DEST_DIR="$ESPANSO_FILE_CONFIG_PATH/match/packages/$PACKAGE_NAME/"

# restart espanso
espanso restart

# Check if the current shell is zsh
if [ -n "$ZSH_VERSION" ]; then
    source ~/.zshrc
# Otherwise, assume it's bash
else
    source ~/.bashrc
fi

echo "esp-gpt installer completed!"