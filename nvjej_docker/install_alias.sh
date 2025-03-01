#!/bin/bash
# install_alias.sh - Adds the nvjej alias to your ~/.zshrc

alias_definition='
nvjej() {
    xhost +local:docker
    if [ -n "$1" ]; then
        # Extract the base name of the folder from $1
        folder_name=$(basename "$1")
        docker run -it \
            -v ~/.ssh:/root/.ssh:ro \
            -v "$1":/root/projects/"$folder_name" \
            -v /tmp/.X11-unix:/tmp/.X11-unix \
            -e DISPLAY=$DISPLAY \
            jeportie/nvjej:latest
    else
        docker run -it \
            -v ~/.ssh:/root/.ssh:ro \
            -v /tmp/.X11-unix:/tmp/.X11-unix \
            -e DISPLAY=$DISPLAY \
            jeportie/nvjej:latest
    fi
}
'

# Append the alias definition to ~/.zshrc if it doesn't already exist.
if ! grep -Fq "nvjej() {" ~/.zshrc; then
    echo "$alias_definition" >> ~/.zshrc
    echo "Alias 'nvjej' added to ~/.zshrc. Please run 'source ~/.zshrc' or restart your terminal."
else
    echo "Alias 'nvjej' already exists in ~/.zshrc."
fi
