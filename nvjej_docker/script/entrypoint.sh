#!/bin/bash
# entrypoint.sh

# If an argument is provided (a mounted project directory), configure it as a safe git directory.
if [ -n "$1" ]; then
    folder_name=$(basename "$1")
    echo "Adding /root/projects/${folder_name} as a safe git directory."
    git config --global --add safe.directory "/root/projects/${folder_name}"
fi

# Launch zsh
exec zsh
