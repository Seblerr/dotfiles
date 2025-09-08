HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory
setopt sharehistory
setopt incappendhistory
setopt hist_ignore_dups
setopt hist_ignore_all_dups
setopt hist_reduce_blanks
setopt autocd
setopt extendedglob

zshaddhistory() {
  [[ $1 != (ls|ll|cd|pwd|exit) ]]
}

export PATH="$HOME/.local/bin:$PATH"
export PATH="$PATH:$HOME/.local/share/nvim/mason/bin"

bindkey -e

bindkey "^[[3~" delete-char
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word
bindkey "\e[A" history-beginning-search-backward
bindkey "\e[B" history-beginning-search-forward

autoload -Uz compinit
compinit
zstyle ':completion:*' special-dirs true
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*' menu select

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

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
[ -f ~/.ghcup/env ] && source ~/.ghcup/env
[ -f ~/.env ] && source ~/.env

command -v fzf >/dev/null && eval "$(fzf --zsh)"
command -v zoxide >/dev/null && eval "$(zoxide init zsh --cmd cd)"

function y() {
  local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
  yazi "$@" --cwd-file="$tmp"
  IFS= read -r -d '' cwd < "$tmp"
  [ -n "$cwd" ] && [ "$cwd" != "$PWD" ] && builtin cd -- "$cwd"
  rm -f -- "$tmp"
}
