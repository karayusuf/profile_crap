# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="crunch"

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git osx ruby bundler rails3)

source $ZSH/oh-my-zsh.sh

# Customize to your needs...
export PATH=/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin:$HOME/.rbenv/shims:$HOME/bin:/usr/local/mysql/bin:$HOME/.rbenv/bin
export PGDATA=/usr/local/pgsql/data
export JAVA_HOME=/System/Library/Java/JavaVirtualMachines/1.6.0.jdk/Contents/Home

eval "$(rbenv init -)"

alias ll='ls -altr'
alias rdtp='rake db:test:prepare'
alias gs='gst'
alias gd='gdv'
alias gcm='git commit -m '
alias go='git co '
alias ree='rbenv shell ree-1.8.7-2012.02'
alias jrb='rbenv shell jruby-1.6.7.2'
alias rb19='rbenv shell 1.9.3-p194'
alias rs='rails server'
alias rc='rails console'

setup_db_for_cust() { 
  MASTER=$1
  CUSTOMER=$2
  cd /usr/local/medsage/databases
  echo "removing existing folder" 
  rm -rf $CUSTOMER
  echo "unzipping $CUSTOMER"
  tar -xvf "$CUSTOMER.tar"
  cd $CUSTOMER
  echo "running bunzip2"
  bunzip2 *.bz2
  echo "dropping db"
  mysql -u root -p'test' < _dropDatabase.sql
  echo "creating db"
  mysql -u root -p'test' < _createDatabase.sql
  echo "loading data"
  mysql -u root -p'test' < _loadData.sql
  echo "loading settings for customer"
  mysql -u root -p'test' "$MASTER" < "/usr/local/medsage/databases/$CUSTOMER/_medsagedb_production_settings.sql"
}

download_cust_db() {
  YEAR=`date +%Y`
  MONTH=`date +%m-%B`
  DAY=`date +%d`
  CUSTOMER=$1
  LOCATION=$2

  krusty_path=/Volumes/CustomerData/database-backups/$YEAR/$MONTH/$DAY/$CUSTOMER.tar

  cd $2
  echo "Grabbing $krusty_path"
  scp atrepanier@10.10.220.8:"$krusty_path" .
}

grab_latest_backup_for_cust() {
  YEAR=`date +%Y`
  MONTH=`date +%m-%B`
  DAY=`date +%d`
  MASTER=$1
  CUSTOMER=$2

  krusty_path=/Volumes/CustomerData/database-backups/$YEAR/$MONTH/$DAY/$CUSTOMER.tar

  cd /usr/local/medsage/databases/
  echo "Grabbing $krusty_path"
  scp atrepanier@10.10.220.8:"$krusty_path" .
  echo "Setting up database for $CUSTOMER"
  setup_db_for_cust $MASTER $CUSTOMER
}

open_pair_session() {
  tmux -S /tmp/pair
  tmux -S /tmp/pair attach
}

rename_brightree_backup() {
  for f in *; do mv -- "$f" "${f//#[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]-/}"; done
}
