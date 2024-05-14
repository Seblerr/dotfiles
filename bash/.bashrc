HISTSIZE=10000
HISTFILESIZE=10000

# shopt
shopt -s autocd
shopt -s direxpand
shopt -s histappend
shopt -s cdspell

# Path
export PATH="$HOME/bin:$PATH"
export PATH="$HOME/nvim-linux64/bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$HOME/.local/share/nvim/mason/bin:$PATH"

# Settings
export COLORTERM="truecolor"
export LESS="-M -I -R"
export EDITOR="nvim"
export FZF_DEFAULT_COMMAND='fd --type f --strip-cwd-prefix --hidden --follow --exclude .git'
export FZF_DEFAULT_OPTS=" \
--color=bg+:#363a4f,bg:#24273a,spinner:#f4dbd6,hl:#ed8796 \
--color=fg:#cad3f5,header:#ed8796,info:#c6a0f6,pointer:#f4dbd6 \
--color=marker:#f4dbd6,fg+:#cad3f5,prompt:#c6a0f6,hl+:#ed8796"

# Aliases
alias ..='cd ..'
alias ll='ls -lAh'
alias mkdir='mkdir -p'
alias tmux='tmux -u'
alias vim='nvim'
alias v='nvim'

parse_git_branch() {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}
export_PS1()
{
  PS1='\[\033[38;5;007m\]\u \[\033[01;34m\]\w \[\033[01;31m\]$(parse_git_branch) \[\033[00m\]\n$ '
}
export_PS1
PROMPT_DIRTRIM=3

# Fzf setup
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# fnm
export PATH="/home/enilseb/.local/share/fnm:$PATH"
eval "`fnm env`"
