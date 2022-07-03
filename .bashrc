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

# Alias/Function definitions
alias ls="ls --color=auto"
alias mv="mv -i"
alias cp="cp -i"
alias ln="ln -i"
alias rm="rm -I --preserve-root"
alias psm="ps ax eo user,comm,pmem,size k pmem"
alias psc="ps ax Seo user,comm,pcpu k pcpu"
alias cpr="rsync -ah --info=progress2"
alias cget="curl -LOC -"
alias .dotfiles="/usr/bin/git --git-dir=${HOME}/.dotfiles/ --work-tree=${HOME}"

# Load fzf if available
if [[ -d "/usr/share/fzf" ]]; then
    source /usr/share/fzf/key-bindings.bash
    source /usr/share/fzf/completion.bash
fi

# Load bash-completion if available
if [[ -f "/usr/share/bash-completion/bash_completion" ]]; then
    source "/usr/share/bash-completion/bash_completion"
fi

# Local overrides
if [[ -f "${HOME}/.bashrc_local" ]]; then
    source "${HOME}/.bashrc_local"
fi

# Load starship prompt if available
if which starship >/dev/null 2>&1; then
    eval "$(starship init bash)"
fi
