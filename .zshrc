export PATH=/opt/homebrew/bin:$HOME/.local/bin:/usr/local/bin:$PATH
export ZSH="$HOME/.oh-my-zsh"
# Set truecolor mode for micro
export MICRO_TRUECOLOR=1
export COLORTERM=truecolor

# Alias/Function definitions
alias ls="ls --color=auto"
alias mv="mv -i"
alias cp="cp -i"
alias ln="ln -i"
alias rm="rm -I"
alias cpr="rsync -ah --progress"
alias cget="curl -LOC -"
alias .dotfiles="/usr/bin/git --git-dir=${HOME}/.dotfiles/ --work-tree=${HOME}"

if [[ $(uname) == "Linux" ]]; then
    # Linux specific
    alias psm="ps axeo user,comm,pmem,size k pmem"
    alias psc="ps axeo user,comm,pcpu k pcpu"
elif [[ $(uname) == "Darwin" ]]; then
    # MacOS Specific
    alias psm="ps axeo user,comm,pmem | (read -r; printf "%s\n" "$REPLY"; sort -nk3)"
    alias psc="ps axeo user,comm,pcpu | (read -r; printf "%s\n" "$REPLY"; sort -nk3)"
    brew -v  &> /dev/null || bootstrap::get_brew && eval "$(brew shellenv)"
    
fi

zstyle ':omz:update' mode reminder
zstyle ':omz:update' frequency 13
setopt extended_history
setopt share_history
setopt hist_ignore_all_dups

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"
COMPLETION_WAITING_DOTS="true"
DISABLE_UNTRACKED_FILES_DIRTY="true"
HYPHEN_INSENSITIVE="true"

plugins=(
    colored-man-pages
    fzf
    gh
    gitfast
    gitignore
    brew
    pip
    python
)

# Check for local overrides
[[ -f "${HOME}/.zshrc_local" ]] && source "${HOME}/.zshrc_local"

# Check/Install various utils
source "${HOME}/.bootstrap"
micro --version &> /dev/null || bootstrap::get_micro
fzf --version &>/dev/null || bootstrap::get_fzf
source "${ZSH}/oh-my-zsh.sh" || bootstrap::get_omz
# This line MUST always be last
starship -V &>/dev/null || bootstrap::get_starship && eval "$(starship init zsh)" 
