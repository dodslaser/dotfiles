# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Set truecolor mode for micro
export MICRO_TRUECOLOR=1
export COLORTERM=truecolor

# Case/typo insensitive glob
shopt -s nocaseglob
shopt -s cdspell

# Immediately store history, ignoring duplicates
shopt -s histappend
export HISTCONTROL=ignoredups
export PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"

# Add ~/.local/bin to PATH
export PATH="${PATH}:${HOME}/.local/bin"

# Alias/Function definitions
alias ls="ls --color=auto"
alias mv="mv -i"
alias cp="cp -i"
alias ln="ln -i"
alias rm="rm -I"

if [[ $(uname) == "Linux" ]]; then
    alias psm="ps axeo user,comm,pmem,size k pmem"
    alias psc="ps axeo user,comm,pcpu k pcpu"
elif [[ $(uname) == "Darwin" ]]; then
    alias psm="ps axeo user,comm,pmem | (read -r; printf "%s\n" "$REPLY"; sort -nk3)"
    alias psc="ps axeo user,comm,pcpu | (read -r; printf "%s\n" "$REPLY"; sort -nk3)"
fi

alias cpr="rsync -ah --progress"
alias cget="curl -LOC -"
alias .dotfiles="/usr/bin/git --git-dir=${HOME}/.dotfiles/ --work-tree=${HOME}"

# Load functions for installing utils
source "${HOME}/.bashrc_bootstrap"

# Load system-wide fzf if available
if [[ -r "/usr/share/fzf/completion.bash" ]]; then
    source "/usr/share/fzf/completion.bash"
elif [[ -r "/usr/local/opt/fzf/shell/completion.bash" ]]; then
    source "/usr/local/opt/fzf/shell/completion.bash"
else
    # install fzf in user-home
    [[ -r "${HOME}/.local/shell/fzf/completion.bash" ]] &&
    [[ -r "${HOME}/.local/shell/fzf/key-bindings.bash" ]] &&
    [[ -r "${HOME}/.local/bin/fzf" ]] ||
        get_fzf &>/dev/null
    source "${HOME}/.local/shell/fzf/key-bindings.bash" &&
    source "${HOME}/.local/shell/fzf/completion.bash" ||
        echo "Unable to install/load fzf"
fi

# Load system-wide bash-completion if available
if [[ -d "/opt/homebrew/etc/bash_completion.d" ]]; then
    export BASH_COMPLETION_COMPAT_DIR="/opt/homebrew/etc/bash_completion.d"
elif [[ -d "/usr/local/etc/bash_completion.d"  ]]; then
    export BASH_COMPLETION_COMPAT_DIR="/usr/local/etc/bash_completion.d"
fi

if [[ -f "/usr/share/bash-completion/bash_completion" ]]; then
    source "/usr/share/bash-completion/bash_completion"
elif [[ -r "/usr/local/share/bash-completion/bash_completion" ]]; then
    source "/usr/local/share/bash-completion/bash_completion"
else
    # install bash-completion in user-home
    [[ -r "${HOME}/.local/share/bash-completion/bash_completion" ]] ||
        get_bash_completion &> /dev/null
    source "${HOME}/.local/share/bash-completion/bash_completion" ||
        echo "Unable to install/load bash-completion"
fi

# Setup homebrew environment if available
[[ -r "/opt/homebrew/bin/brew" ]] && eval "$(/opt/homebrew/bin/brew shellenv)"

# Local overrides
[[ -f "${HOME}/.bashrc_local" ]] && source "${HOME}/.bashrc_local"

# Load starship prompt if available
if starship -V &>/dev/null; then
    eval "$(starship init bash)"
else
    # install starship in user-home
    [[ -r "${HOME}/.local/share/bash_completion" ]] ||
        get_starship &>/dev/null
    eval "$(${HOME}/.local/bin/starship init bash)" ||
        echo "Unable to install/load starship"
fi
