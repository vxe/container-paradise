export CLASSPATH=~/.emacs.d/lib

for jar in `find ~/.emacs.d/bin -iname '*.jar'`
do
    CLASSPATH=${CLASSPATH}:${jar}
done

export CPPFLAGS="$CPPFLAGS -I/usr/local/opt/icu4c/include"



export GOBIN="$HOME/.emacs.d/bin"

mkdir -p ~/.emacs.d/.go
export GOPATH="$HOME/.go"
export PATH="$PATH:$GOPATH/bin"

export GSL_VERSION="2.4"

export SAVEHIST=1000000
export HISTFILE=~/.zhistory

export LDFLAGS="$LDFLAGS  -L/usr/local/opt/icu4c/lib"

export LTDL_LIBRARY_PATH="$HOME/.emacs.d/lib"

export PATH="$HOME/bin:$PATH"

export PATH=$PATH:/usr/local/opt/go/libexec/bin

export PATH=$PATH:$HOME/.emacs.d/opt/rebar3

export PATH="$HOME/.ndenv/bin:$PATH"

export PKG_CONFIG_PATH="$PKG_CONFIG_PATH:/usr/local/opt/icu4c/lib/pkgconfig"
export PKG_CONFIG_PATH="$PKG_CONFIG_PATH:/usr/local/Cellar/zlib/1.2.8/lib/pkgconfig:/usr/local/lib/pkgconfig:/opt/X11/lib/pkgconfig"

export PS2=''

export PYTHONSTARTUP="$HOME/.pythonrc.py"

export TERM=xterm-256color
