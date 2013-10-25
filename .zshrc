#
# setting environmental variables
#
export LANG=ja_JP.UTF-8

#
# setting complement
#
autoload -U compinit
compinit
# pack complement list
setopt list_packed
# auto sugestion
autoload predict-on
predict-on

#
# setting PROMPTs
#
case ${UID} in
0)
  PROMPT="%B%{[31m%}%n%%%{[m%}%b "
  PROMPT2="%B%{[31m%}%_%%%{[m%}%b "
  RPROMPT="%B%{[31m%}[%32<...<%~]%%%{[m%}%b"
  ;;
*)
  PROMPT="%B%{[34m%}%n%%%{[m%}%b "
  PROMPT2="%B%{[34m%}%_%%%{[m%}%b "
  RPROMPT="%B%{[34m%}[%32<...<%~]%%%{[m%}%b"
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

