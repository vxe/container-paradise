# eval "$(rbenv init -)"

# export RUBY_VERSION=2.5.1

# if [[ `which ruby | grep usr` ]]
#   then
#       rbenv install $RUBY_VERSION
#   fi

# rbenv global $RUBY_VERSION

# eval $(perl -I$HOME/perl5/lib/perl5 -Mlocal::lib)

function start-collectd(){
    /usr/local/sbin/collectd -f -C /usr/local/etc/collectd.conf &
}

function ikill () {
    let to_kill=`ps -eaf | grep $1 | yank`
    sudo kill -9 $to_kill
}

function redo() {
     history 0 | awk '{$1=""; print $0}' | peco | yank -l
}

export SAVEHIST=10000
export HISTSIZE=10000
export HISTFILE=~/.zsh_history

## Colorize the ls output ##
alias ls='ls -G'

## Use a long listing format ##
alias ll='ls -la'

## Show hidden files ##
alias l.='ls -d .* --color=auto'

export LSCOLORS=gxBxhxDxfxhxhxhxhxcxcx

alias clush='clush -o "-A"'

alias java-repl="java -jar ~/.emacs.d/opt/java-repl/build/libs/javarepl-dev.jar"

if [ -n "$INSIDE_EMACS" ]; then
  chpwd() { print -P "\033AnSiTc %d" }
  print -P "\033AnSiTu %n"
  print -P "\033AnSiTc %d"
fi  

    # ## emacs
    #   chpwd() { print -P "\033AnSiTc %d" }

    #   print -P "\033AnSiTu %n"
    #   print -P "\033AnSiTc %d"

eval "$(ndenv init -)"

source ~/.zsh.d/zsh-git-prompt/zshrc.sh
source ~/.zprompt

if [[ -e ~/.zwork ]]
then
    source ~/.zwork
fi

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/vedwin/opt/google-cloud-sdk/path.zsh.inc' ]; then source '/Users/vedwin/opt/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/vedwin/opt/google-cloud-sdk/completion.zsh.inc' ]; then source '/Users/vedwin/opt/google-cloud-sdk/completion.zsh.inc'; fi
