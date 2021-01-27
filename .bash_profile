export GOPATH="$HOME/.go"

export ANDROID_HOME=$HOME/Android/Sdk
export ANDROID_SDK_ROOT=$HOME/Android/Sdk

export PATH="$HOME/.poetry/bin:$HOME/.cargo/bin:$PATH:$GOPATH/bin:$ANDROID_HOME/tools:$ANDROID_HOME/tools/bin:$ANDROID_HOME/platform-tools"

if [ -e $HOME/.bash_profile.local ]; then
    source $HOME/.bash_profile.local
fi

export XIM_PROGRAM=fcitx
export XIM=fcitx
export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS="@im=fcitx"

# rbenv
if [ -d $HOME/.rbenv/bin ]; then
    export PATH="$HOME/.rbenv/bin:$PATH"
fi
