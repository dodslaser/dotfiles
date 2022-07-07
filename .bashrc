# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Set truecolor mode for micro
export MICRO_TRUECOLOR=1

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
    if [[ -r "${HOME}/.local/shell/fzf/completion.bash" ]]; then
        source "${HOME}/.local/shell/fzf/completion.bash"
    elif get_fzf; then
        source "/usr/share/fzf/completion.bash"
    else
        echo "Unable to install/load fzf"
    fi
fi

# Load system-wide bash-completion if available
if [[ -f "/usr/share/bash-completion/bash_completion" ]]; then
    source "/usr/share/bash-completion/bash_completion"
elif [[ -r "/usr/local/etc/profile.d/bash_completion.sh" ]]; then
    export BASH_COMPLETION_COMPAT_DIR="/usr/local/etc/bash_completion.d"
    source "/usr/local/etc/profile.d/bash_completion.sh"
else
    # install bash-completion in user-home
    if [[ -r "${HOME}/.local/share/bash_completion" ]]; then
        source "${HOME}/.local/share/bash_completion"
    elif get_bash_completion; then
        source "${HOME}/.local/share/bash_completion"
    else
        echo "Unable to install/load bash-completion"
    fi
fi


# Local overrides
if [[ -f "${HOME}/.bashrc_local" ]]; then
    source "${HOME}/.bashrc_local"
fi


# Load starship prompt if available
if starship -V &>/dev/null; then
    eval "$(starship init bash)"
else
    # install starship in user-home
    if [[ -r "${HOME}/.local/share/bash_completion" ]]; then
        eval "$(${HOME}/.local/bin/starship init bash)"
    elif get_starship: then
        eval "$(${HOME}/.local/bin/starship init bash)")
    else
        echo "Unable to install/load starship"
    fi
fi
