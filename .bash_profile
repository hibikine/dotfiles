export GOPATH="$HOME/.go"
export PATH="$PATH:$GOPATH/bin"

export PATH="$HOME/.cargo/bin:$PATH"

if [ -e $HOME/.bash_profile.local ]; then
    source $HOME/.bash_profile.local ]
fi

