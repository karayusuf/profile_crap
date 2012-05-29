function parse_git_branch {
  git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}

function proml {
  local        BLUE="\[\033[0;34m\]"
  local         RED="\[\033[0;31m\]"
  local   LIGHT_RED="\[\033[1;31m\]"
  local       GREEN="\[\033[0;32m\]"
  local LIGHT_GREEN="\[\033[1;32m\]"
  local       WHITE="\[\033[1;37m\]"
  local  LIGHT_GRAY="\[\033[0;37m\]"
  case $TERM in
    xterm*)
    TITLEBAR='\[\033]0;\u@\h:\w\007\]'
    ;;
    *)
    TITLEBAR=""
    ;;
  esac

PS1="${TITLEBAR}\
$BLUE[$RED\$(date +%H:%M)$BLUE]\
$BLUE[$RED\u@\h:\w$GREEN\$(parse_git_branch)$BLUE]\
$GREEN\$ "
PS2='> '
PS4='+ '
}
proml


export PATH=$PATH:~/bin:/usr/local/mysql/bin/

export CC=/usr/bin/gcc-4.2

alias gs='git status '
alias ga='git add '
alias gb='git branch '
alias gba='git branch -a '
alias gc='git commit'
alias gd='git diff'
alias go='git checkout '
alias gk='gitk --all&'
alias gx='gitx --all'
alias gcm='git commit -m'
alias gh='git hist'

alias got='git '
alias get='git '
alias r='script/rails'

ll () { ls -Flas "$@" ; }        # long listing, function
alias ll='ls -Flas'              # long listing, alias

alias ber='bundle exec rake'
alias cdef='cucumber -p default'
alias cwip='cucumber -p wip'
alias cjs='cucumber -p javascript'
alias call='cucumber -p all'
alias be='bundle exec'

export EDITOR=vim

[[ -s $HOME/.rvm/scripts/rvm ]] && source $HOME/.rvm/scripts/rvm  # This loads RVM into a shell session.
[[ -s $HOME/.tmuxinator/scripts/tmuxinator ]] && source $HOME/.tmuxinator/scripts/tmuxinator
