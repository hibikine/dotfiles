export GOPATH="$HOME/.go"
export PATH="$PATH:$GOPATH/bin"

export PATH="$HOME/.cargo/bin:$PATH"
export ANDROID_HOME=$HOME/Android/Sdk
export PATH=$PATH:$ANDROID_HOME/tools:$ANDROID_HOME/tools/bin:$ANDROID_HOME/platform-tools
export ANDROID_SDK_ROOT=$HOME/Android/Sdk

if [ -e $HOME/.bash_profile.local ]; then
    source $HOME/.bash_profile.local ]
fi

