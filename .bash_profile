PS1="\[\033[0;33m\][\!]\`if [[ \$? = "0" ]]; then echo "\\[\\033[32m\\]"; else echo "\\[\\033[31m\\]"; fi\`[\u.\h: \`if [[ `pwd|wc -c|tr -d " "` > 18 ]]; then echo "\\W"; else echo "\\w"; fi\`]\$\[\033[0m\] "; echo -ne "\033]0;`hostname -s`:`pwd`\007"
export PATH=$PATH:~/bin

[[ -s "/Users/adam/.rvm/scripts/rvm" ]] && source "/Users/adam/.rvm/scripts/rvm"  # This loads RVM into a shell session.
export CC=/usr/bin/gcc-4.2

alias gs='git status '
alias ga='git add '
alias gb='git branch '
alias gc='git commit'
alias gd='git diff'
alias go='git checkout '
alias gk='gitk --all&'
alias gx='gitx --all'
alias gcm='git commit -m'

alias got='git '
alias get='git '
