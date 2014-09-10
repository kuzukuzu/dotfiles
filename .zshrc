#
# setting environmental variables
#
export LANG=ja_JP.UTF-8
export PATH="~/.rbenv/shims:/usr/local/bin:$PATH"
eval "$(rbenv init -)"
export PYTHONSTARTUP=~/.pythonstartup
export PATH="/Applications/gnuplot.app:/Applications/gnuplot.app/bin:$PATH"

#
# setting completion
#
autoload -U compinit
compinit
# pack completion list
setopt list_packed
# auto sugestion
# autoload predict-on
# predict-on
# don't remove postfix slash
setopt noautoremoveslash

#
# setting PROMPTs
#
case ${UID} in
0)
  # prompt_dir="%B%{[31m%}[%32<...<%~]%{[m%}%b"
  prompt_dir="[%32<...<%~]"
  prompt_time="%D{%T}"
  prompt_user="%B%{[31m%}%n%{[m%}%b"
  [ -n "${REMOTEHOST}${SSH_CONNECTION}" ] &&
    prompt_user="${prompt_user}%B%{[37m%}@${HOST%%.*}%{[m%}%b"
  PROMPT=$'\n'"["$prompt_user" "$prompt_time"]"$prompt_dir$'\n''%% '
  PROMPT2="%B%{[31m%}%_>%{[m%}%b "
  ;;
*)
  # prompt_dir="%B%{[34m%}[%32<...<%~]%{[m%}%b"
  prompt_dir="[%32<...<%~]"
  prompt_time="%D{%T}"
  prompt_user="%B%{[34m%}%n%{[m%}%b"
  # PROMPT="%B%{[34m%}_(┐「ε:)_%{[m%}%b "
  [ -n "${REMOTEHOST}${SSH_CONNECTION}" ] &&
    prompt_user="${prompt_user}%B%{[37m%}@${HOST%%.*}%{[m%}%b"
  PROMPT=$'\n'"["$prompt_user" "$prompt_time"]"$prompt_dir$'\n''%% '
  PROMPT2="%B%{[34m%}%_>%{[m%}%b "
  ;;
esac

#
# setting terminal title
#
case ${TERM} in
kterm*|xterm*)
  precmd() {
    echo -ne "\033]0;${USER}@${HOST%%.*}:${PWD}\007"
  }
  ;;
esac

#
# setting histry
#
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
# ignore duplication command history list
setopt hist_ignore_dups
# share command history data
setopt share_history

#
# setting search keybind
#
bindkey -e
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end

#
# setting about cd
#
setopt auto_cd
setopt auto_pushd

#
# setting command corrent
#
setopt correct

# invalidate beep sound
setopt nolistbeep

#
# setting lscolors
#
# export LSCOLORS=exfxcxdxbxegedabagacad
export LSCOLORS=ExFxCxdxBxegedabagacad
case ${OSTYPE} in
freebsd*|darwin*)
  alias ls="ls -G -w"
  ;;
linux*)
  alias ls="ls --color"
  ;;
esac
# completion colors
# zstyle ':completion:*' list-colors 'di=34' 'ln=35' 'so=32' 'ex=31' 'bd=46;34' 'cd=43;34'
zstyle ':completion:*' list-colors 'di=;34;1' 'ln=;35;1' 'so=;32;1' 'ex=31;1' 'bd=46;34' 'cd=43;34'

# using when writing each environment's settings
# [ -f ~/.zshrc.mine ] && source ~/.zshrc.mine

#
# settin aliases
#
setopt complete_aliases

alias where="command -v"
alias j="jobs -l"

alias la="ls -a"
alias lf="ls -F"
alias ll="ls -l"

alias du="du -h"
alias df="df -h"

alias su="su -l"

alias cdb="cd .."

# tmux
alias tm='tmux'
alias tma='tmux attach'
alias tml='tmux list-window'
alias memo="vim $HOME/.worktrace"

#
# quick executers
#
alias -s c=zsh_c_executer
alias -s rb=ruby

zsh_c_executer()
{
  gcc ${@+"$@"}
  ./a.out
}

#
# show git branch
#
autoload -Uz vcs_info
zstyle ':vcs_info;*' formats '[%b]'
zstyle ':vcs_info;*' actionformats '[%b|%a]'
precmd () {
  psvar=()
  LANG=en_US.UTF-8 vcs_info
  [[ -n "$vcs_info_msg_0_" ]] && psvar[1]="$vcs_info_msg_0_"
}
RPROMPT="%1(v|%F{green}%1v%f|)"$RPROMPT
