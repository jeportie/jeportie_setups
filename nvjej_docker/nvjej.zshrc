export DEFAULT_USER="nvjej"

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="agnoster"

HISTFILE=/dev/null
ZSH_COMPDUMP=/tmp/zcompdump

plugins=(
    git
    dirhistory 
    copypath 
    web-search 
    sudo 
    npm
)

VENV_PATH="/root/venv/bin/activate"

if [ -f "$VENV_PATH" ]; then
    source "$VENV_PATH"
    echo "Virtual environment activated."
else
    echo "Virtual environment not found at $VENV_PATH"
fi

source $ZSH/oh-my-zsh.sh

alias venv="source /root/venv/bin/activate"

alias vi="vim"
alias vim="nvim"

pause() {
    if [ -n "$1" ]; then
        COMMIT=$(basename "$1")
    else
        COMMIT="push pause"
    fi
    git add . && git commit -m "$COMMIT" && git push && git status
}

