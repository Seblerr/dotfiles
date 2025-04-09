HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory
setopt sharehistory 
setopt incappendhistory
setopt autocd 
setopt extendedglob

bindkey "\e[A" history-beginning-search-backward
bindkey "\e[B" history-beginning-search-forward

bindkey -e

zstyle :compinstall filename '/home/$USER/.zshrc'
autoload -Uz compinit
compinit

function parse_git_branch() {
    git branch 2> /dev/null | sed -n -e 's/^\* \(.*\)/[\1]/p'
}
COLOR_DEF=$'%f'
COLOR_USR=$'%F{243}'
COLOR_DIR=$'%F{197}'
COLOR_GIT=$'%F{39}'
setopt PROMPT_SUBST
export PROMPT='${COLOR_USR}%n ${COLOR_DIR}%~ ${COLOR_GIT}$(parse_git_branch)${COLOR_DEF} $ '
export EDITOR='nvim'

alias v='nvim'
alias g='git'
alias ls='ls --color=auto -hv'
alias ll='ls -lAh'

eval "$(fzf --zsh)"
eval "$(zoxide init zsh --cmd cd)"
