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
			-v ~/.zsh_history:/root/.zsh_history \
            -e DISPLAY=$DISPLAY \
			-w "/root/projects/$folder_name" \
            jeportie/nvjej:latest
    else
        docker run -it \
            -v ~/.ssh:/root/.ssh:ro \
            -v /tmp/.X11-unix:/tmp/.X11-unix \
			-v ~/.zsh_history:/root/.zsh_history \
            -e DISPLAY=$DISPLAY \
            jeportie/nvjej:latest
    fi
}
'

alias_definition2='
sepcat() {
  # If no arguments, use the default glob pattern
  if [ "$#" -eq 0 ]; then
    set -- */*
  fi

  for file in "$@"; do
    if [ -f "$file" ]; then
      echo "===== $file ====="
      cat "$file"
    fi
  done
}
'

# Append the alias definition to ~/.zshrc if it doesn't already exist.
if ! grep -Fq "nvjej() {" ~/.zshrc; then
    echo "$alias_definition" >> ~/.zshrc
    echo "Alias 'nvjej' added to ~/.zshrc. Please run 'source ~/.zshrc' or restart your terminal."
else
    echo "Alias 'nvjej' already exists in ~/.zshrc."
fi
# Append the alias definition2 to ~/.zshrc if it doesn't already exist.
if ! grep -Fq "sepcat() {" ~/.zshrc; then
    echo "$alias_definition2" >> ~/.zshrc
    echo "Alias 'sepcat' added to ~/.zshrc. Please run 'source ~/.zshrc' or restart your terminal."
else
    echo "Alias 'sepccat' already exists in ~/.zshrc."
fi
