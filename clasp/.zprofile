set -o pipefail

# # set -u

# mkdir -p ~/src
# mkdir -p ~/opt
# mkdir -p ~/.zsh.d

# function install-which(){
#     if [[ `uname` == "Darwin" ]]
#     then
#         if [[ `which $1` > 0 ]]
#         then
#             brew install $1
#         fi
#     fi

# }

# function install-brew(){
#   if [[ `uname` == "Darwin" ]]
#   then
#       if [[ ! `brew list | grep $1` > 0 ]]
#       then
#           brew install $1
#       fi
#   fi
# }

# function install-locate() {

#   if [[ `uname` == "Darwin" ]]
#   then
#       if [[ ! `locate $1` ]]
#       then
#           brew install $1
#       fi
#   fi

# }

# if [[ `uname` == "Darwin" ]]
# then
#     if [[ `which yank` > 0 ]]
#     then
#         brew install yank
#     fi
# fi

# # function install-fancy-prompt() {
#  #     (cd $HOME/.zsh.d && https://github.com/olivierverdier/zsh-git-prompt.git) && source ~/.zh
#  # } 

# if [[ ! -e ~/.zsh.d/zsh-git-prompt ]]
# then
#     cd ~/.zsh.d ; git clone https://github.com/olivierverdier/zsh-git-prompt.git
#     cd ~/.zsh.d/zsh-git-prompt
#     stack build && stack install
#     export GIT_PROMPT_EXECUTABLE="haskell"
# fi


# # if [[ ! -e ~/.zsh.d/powerlevel9k ]]
# # then
# #     cd ~/.zsh.d ; git clone https://github.com/bhilburn/powerlevel9k.git
# #     echo 'source  ~/.zsh.d/powerlevel9k/powerlevel9k.zsh-theme' >> ~/.zprompt
# #     brew tap caskroom/fonts
# #     brew cask install font-hack-nerd-font
# # fi

# if [[ ! -e $HOME/.emacs.d/opt/rebar3 ]]
# then
# cd ~/.emacs.d/opt
# git clone https://github.com/erlang/rebar3.git
# cd rebar3
# ./bootstrap
# fi

# if [[ `uname` == "Darwin" ]]
# then
#     if [[ ! `find $HOME/.emacs.d/eclipse.jdt.ls/server/jdt-language-server-latest.tar.gz` ]]
#     then
# mkdir -p ~/.emacs.d/eclipse.jdt.ls/server/; cd ~/.emacs.d/eclipse.jdt.ls/server/; wget http://download.eclipse.org/jdtls/snapshots/jdt-language-server-latest.tar.gz; tar xvf jdt-language-server-latest.tar.gz; 
#     fi
# fi

# if [[ `uname` == "Darwin" ]]
#   then
#       if [[ ! `find $HOME/.emacs.d/opt/java-repl` ]]
#       then
#           cd ~/.emacs.d/opt
#           git clone https://github.com/albertlatacz/java-repl.git; 
#           cd ~/.emacs.d/opt/java-repl;
#           gradle shadowJar;          
#       fi
#   fi

# alias java-repl="java -jar ~/.emacs.d/opt/java-repl/build/libs/javarepl-dev.jar"

# if [[ `uname` == "Darwin" ]]
# then
#     if [[ `which epdfinfo` > 0 ]]
#     then
#         cd ~/Downloads;
#         git clone https://github.com/politza/pdf-tools.git
#         cd ~/Downloads/pdf-tools/servce;
#         autoreconf -i;
#         ./configure
#         make && sudo make install
#     fi
# fi

# if [[ ! -e ~/.emacs.d/opt/quicklisp.lisp ]]
# then
# cd ~/.emacs.d/opt
# curl -O https://beta.quicklisp.org/quicklisp.lispcurl -O https://beta.quicklisp.org/quicklisp.lisp
# sbcl --load quicklisp.lisp
# fi

# if [[ `uname` == "Darwin" ]]
# then
#     if [[ ! `which ctags` ]]
#     then
#         cd ~/Downloads
#         wget "https://downloads.sourceforge.net/project/ctags/ctags/5.8/ctags58.zip?r=https%3A%2F%2Fsourceforge.net%2Fprojects%2Fctags%2Ffiles%2Fctags%2F5.8%2Fctags58.zip%2Fdownload%3Fuse_mirror%3Dayera&ts=1527406736&use_mirror=ayera"
#         unzip ctags58.zip
#         cd ctags58
#         ./configure
#         make && sudo make install
#     fi
# fi

# # wget http://mirrors.syringanetworks.net/gnu/gsl/gsl-$GSL_VERSION.tar.gz

# if [[ `uname` == "Darwin" ]]
# then
#     if [[ ! -e "$HOME/.zsh.d/zshdb" ]]
#     then
#         cd ~/.zsh.d/
#         git clone git://github.com/rocky/zshdb.git
#         cd zshdb
#         ./autogen.sh  # Add configure options. See ./configure --help
#         ./configure
#         make && sudo make install

#     fi
# fi

# if [[ `uname` == "Darwin" ]]
# then
#     if [[ ! `which pip` ]]
#     then
#         sudo easy_install pip
#     fi
# fi

# if [[ `uname` == "Darwin" ]]
# then
#     if [[ ! `which virtualenv` ]]
#     then
#         sudo pip install virtualenv
#     fi
# fi

# # create
#   if [[ ! -e ~/.emacs.d/var ]]; then mkdir -p ~/.emacs.d/var; if [[ ! -e ~/.emacs.d/var/emacs ]]; then cd ~/.emacs.d/var/ ; virtualenv emacs; fi; fi
# # switch to

#   if [[ -e ~/.emacs.d/var/emacs ]]; then source ~/.emacs.d/var/emacs/bin/activate; fi

# if [[ `uname` == "Darwin" ]]
# then
#     if [[ ! `rbenv --version` ]]
#     then
#         brew install rbenv
#     fi
# fi

# eval "$(rbenv init -)"

# if [[ `uname` == "Darwin" ]]
# then
#     if [[ ! `gem list | grep bundler` > 0 ]]
#     then
#         gem install bundler
#     fi
# fi

# if [[ `uname` == "Darwin" ]]
# then
#     if [[ ! `gem list | grep faraday` > 0 ]]
#     then
#         gem install faraday
#     fi
# fi

# if [[ `uname` == "Darwin" ]]
# then
#     if [[ ! `gem list | grep method_source` > 0 ]]
#     then
#         gem install method_source
#     fi
# fi

# if [[ `uname` == "Darwin" ]]
# then
#     if [[ ! `gem list | grep pry` > 0 ]]
#     then
#         gem install pry
#     fi
# fi

# if [[ `uname` == "Darwin" ]]
# then
#     if [[ ! `gem list | grep pry-doc` > 0 ]]
#     then
#         gem install pry-doc
#     fi
# fi

# if [[ `uname` == "Darwin" ]]
# then
#     if [[ ! `gem list | grep puppet-debugger` > 0 ]]
#     then
#         gem install puppet-debugger
#     fi
# fi

# if [[ `uname` == "Darwin" ]]
# then
#     if [[ ! `gem list | grep rubocop` > 0 ]]
#     then
#         gem install rubocop
#     fi
# fi

# if [[ `uname` == "Darwin" ]]
# then
#     if [[ ! `gem list | grep yard` > 0 ]]
#     then
#         gem install yard
#     fi
# fi

# if [[ `uname` == "Darwin" ]]
# then
#     if [[ ! `gem list | grep dockly` > 0 ]]
#     then
#         gem install dockly
#     fi
# fi

# export NVM_DIR="$HOME/.nvm"
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
# [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# #+END_SRC#+BEGIN_SRC sh :tangle ~/.zprofile

# export NVM_DIR="$HOME/.nvm"
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
# [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# if [[ `uname` == "Darwin" ]]
#   then
#       if [[ ! -e ~/.ndenv ]]
#       then
#           git clone https://github.com/riywo/ndenv ~/.ndenv          
#       fi
#   fi

# # eval "$(ndenv init -)"
# # exec $SH -l

# if [[ `uname` == "Darwin" ]]
# then
#     if [[ ! -e ~/.ndenv/plugins/node-build ]]
#     then
#         git clone https://github.com/riywo/node-build.git $(ndenv root)/plugins/node-build
#     fi
# fi

# if [[ `uname` == "Darwin" ]]
# then
#     if [[ ! `find $GOPATH -maxdepth 4 | grep color` ]]
#     then
#     go get github.com/fatih/color 
#     fi
# fi

# if [[ `uname` == "Darwin" ]]
# then
#     if [[ ! `which dep` ]]
#     then
#         brew install dep
#     fi
# fi

# if [[ `uname` == "Darwin" ]]
# then
#     if [[ ! `which gocode` ]]
#     then
#         go get -u github.com/nsf/gocode &
#     fi
# fi

# if [[ `uname` == "Darwin" ]]
# then
#     if [[ ! `which godoc` ]]
#     then
#         go get github.com/rogpeppe/godef &
#     fi
# fi

# if [[ `uname` == "Darwin" ]]
# then
#     if [[ ! `find $GOPATH -maxdepth 4 | grep golang-set` ]]
#     then
#     go get github.com/deckarep/golang-set 
#     fi
# fi

# if [[ `uname` == "Darwin" ]]
# then
#     if [[ ! `find $GOPATH -maxdepth 4 | grep now` ]]
#     then
#     go get -u github.com/jinzhu/now 
#     fi
# fi

# if [[ `uname` == "Darwin" ]]
# then
#     if [[ ! `find $GOPATH -maxdepth 4 | grep nsq` ]]
#     then
#     go get -u github.com/nsqio/nsq
#     fi
# fi

# if [[ `uname` == "Darwin" ]]
# then
#     if [[ `find $HOME -maxdepth 1 -name perl5` > 0 ]]
#     then
#         sudo cpan local::lib
#     fi
# fi

# eval $(perl -I$HOME/perl5/lib/perl5 -Mlocal::lib)

# mkdir -p "$HOME/perl5/bin"

# if [[ ! -w "$HOME/perl5" ]]
# then
# sudo chmod -R a+w "$HOME/perl5"
# fi

# if [[ `uname` == "Darwin" ]]
# then
#     if [[ ! `perldoc -l 'App::cpanminus'` ]]
#     then
#         sudo cpan App::cpanminus
#     fi
# fi

# if [[ `uname` == "Darwin" ]]
# then
#     if [[ `find $HOME/perl5 -name DBI` > 0 ]]
#     then
#         cpanm -i DBI
#     fi
# fi

# if [[ `uname` == "Darwin" ]]
# then
#     if [[ `find $HOME/perl5 -iname 'SQL'` > 0 ]]
#     then
#         cpanm -i DBD::SQLite
#     fi
# fi

# if [[ `uname` == "Darwin" ]]
# then
#     if [[ `find $HOME/perl5 -iname 'PG'` > 0 ]]
#     then
#         cpanm -i DBD::Pg
#     fi
# fi

# if [[ `uname` == "Darwin" ]]
# then
#     if [[ `find $HOME/perl5 -iname RPC | grep EPC` > 0 ]]
#     then
#         cpanm -i RPC::EPC::Service
#     fi
# fi

# if [[ `uname` == "Darwin" ]]
# then
#     if [[ `find $HOME/perl5 -iname 'Roman*'` > 0 ]]
#     then
#         cpanm -i Roman
#     fi
# fi

# if [[ `uname` == "Darwin" ]]
#   then
#       if [[ `find $HOME/perl5 -iname 'Term::ReadKey*'` > 0 ]]
#       then
#           cpanm -i Term::ReadKey
#       fi
#   fi

# if [[ `uname` == "Darwin" ]]
#   then
#       if [[ `find $HOME/perl5 -iname 'HTTP::Status*'` == "" ]]
#       then
#           cpanm -i HTTP::Status
#       fi
#   fi

# if [[ `uname` == "Darwin" ]]
#   then
#       if [[ `find $HOME/perl5 -iname 'Net::MAC*'` == "" ]]
#       then
#           cpanm -i Net::MAC
#       fi
#   fi

# if [[ `uname` == "Darwin" ]]
#   then
#       if [[ `find $HOME/perl5 -iname 'Zodiac::Tiny*'` == "" ]]
#       then
#           cpanm -i Zodiac::Tiny
#       fi
#   fi

# if [[ `uname` == "Darwin" ]]
#   then
#       if [[ `find $HOME/perl5 -iname 'Statistics::R*'` == "" ]]
#       then
#           cpanm -i Statistics::R
#       fi
#   fi

# if [[ `uname` == "Darwin" ]]
#   then
#       if [[ `find $HOME/perl5 -iname 'PDL*'` == "" ]]
#       then
#           cpanm -i PDL
#       fi
#   fi

mkdir -p ~/.guile.d/lib/sicp


if [[ ! -e ~/.guile.d/lib/sicp/allcode.tar.gz ]]
then
    cd ~/.guile.d/lib/sicp
    wget https://mitpress.mit.edu/sites/default/files/sicp/code/allcode.tar.gz
    tar xvf allcode.tar.gz
fi

if [[ ! -e "~/.zwork" ]]
then
    touch ~/.zwork
    source ~/.zwork
else
    source ~/.zwork
fi

chpwd() {
    print -P "\033AnSiTc %d";
}

# print -P "\033AnSiTu %n"
# print -P "\033AnSiTc %d"
