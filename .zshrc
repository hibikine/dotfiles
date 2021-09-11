unsetopt BG_NICE
source ~/.zplug/init.zsh

zplug "zplug/zplug", hook-build:"zplug --self-manage"
zplug "mafredri/zsh-async"
zplug "sindresorhus/pure"
zplug "b4b4r07/enhancd", use:init.sh
zplug "zsh-users/zsh-syntax-highlighting"
zplug "zsh-users/zsh-autosuggestions"
zplug "zsh-users/zsh-history-substring-search", defer:2
zplug "zsh-users/zsh-completions"
zplug "chrissicool/zsh-256color"
zplug "junegunn/fzf-bin", as:command, from:gh-r, rename-to:fzf
zplug "peco/peco", as:command, from:gh-r, use:"*amd64*"
zplug "plugins/docker", from:oh-my-zsh
zplug "plugins/docker-compose", from:oh-my-zsh
zplug load --verbose

# zmvコマンドを有効化
autoload -U zmv

# PATH settings
export PATH="$PATH:$HOME/.npm-global/bin:$HOME/.cargo/bin:/usr/local/go/bin:$HOME/.local/bin:$HOME/.rbenv/bin:$HOME/.config/composer/vendor/bin:$HOME/.cargo/bin:/home/linuxbrew/.linuxbrew/bin:$HOME/.config/yarn/global/node_modules/.bin:$HOME/.local/bin:$HOME/bin/flutter/bin:/snap/bin:$HOME/.nodebrew/current/bin"

if [[ -s "$HOME/src/google-cloud-sdk" ]]; then
    source $HOME/src/google-cloud-sdk/completion.zsh.inc
    source $HOME/src/google-cloud-sdk/path.zsh.inc
fi

# History

# 保存先
export HISTFILE=${HOME}/.zsh_history
# メモリに保存されるヒストリ件数
export HISTSIZE=100000
# 履歴ファイルに保存される履歴件数
export SAVEHIST=100000
# 開始と終了を記録する
setopt EXTENDED_HISTORY
# historyを共有
setopt share_history
# ヒストリに追加されるコマンド行が古いものと同じなら古いものを削除
setopt hist_ignore_all_dups
# スペースで始まるコマンド行を無視
setopt hist_ignore_space
setopt hist_ignore_dups
setopt hist_verify
setopt hist_save_no_dups
setopt hist_expand
setopt inc_append_history
# ヒストリコマンドは履歴に登録しない
setopt hist_no_store


# pure config
autoload -U promptinit; promptinit
prompt pure
PURE_PROMPT_SYMBOL=">"
zstyle :prompt:pure:path color cyan

# enhancd config
#export ENHANCD_DISABLE_DOT=1
export ENHANCD_FILTER=fzy:fzf:peco
export GOPATH="$HOME/go"

# Home
WHOAMI=$(whoami)

# Aliases
alias cd..="cd .."
alias dotf="cd ~/dotfiles"
alias winsrc="cd /mnt/c/Users/Kage/src/"
alias winHome="cd /mnt/c/Users/$USER/"
alias getmyip="curl inet-ip.info"
alias grep='grep --color'
alias df='df -h'
alias dusc='du -s -c *'
alias password='python3 -c "from secrets import choice;from string import ascii_letters, digits;print(\"\".join([choice(ascii_letters+digits) for _ in range(12)]))"'
alias passwordalt='python -c "from random import choice;from string import ascii_letters, digits;print(\"\".join([choice(ascii_letters+digits) for _ in range(12)]))"'
alias getwslip="ip a | grep -E '172\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' -m1 -o | head -n 1"
alias untgz='tar -xzvf'
alias untbz='tar -xjvf'
alias docker-all-stop='docker stop $(docker ps -a -q)'
alias tasksync='git -C ~/.task add --all && git -C ~/.task commit -m "sync task" && git -C ~/.task push'

# ls aliases
if [ "$(uname)" = 'Darwin' ]; then
    # export LSCOLORS=xbfxcxdxbxegedabagacad
    alias ls='ls -G'
else
    # eval `dircolors ~/.colorrc`
    alias ls='ls --color=auto'
fi
alias ll='ls -la --color=auto'
alias la='ls -la --color=auto'
alias sl='ls'
if type xsel >/dev/null 2>&1; then
    alias clipboard='xsel --clipboard --input'
fi
export LSCOLORS=gxfxcxdxbxegedabagacad
export LS_COLORS='di=36:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
zstyle ':completion:*' list-colors 'di=34' 'ln=35' 'so=32' 'ex=31' 'bd=46;34' 'cd=43;34'

# git aliases
alias hyperlog="git log --oneline --graph --decorate=full"
alias lg=hyperlog
alias gaa='git add --all'
alias gc='git checkout'
alias gk='git checkout'
alias gcb='git checkout -b'
alias gkb='git checkout -b'
alias gs='git status'
alias gb='git branch'
alias gcm='git checkout master'
alias gkm='git checkout master'
alias gpu='git pull'
alias gu='git pull'
alias gpom='git pull origin master'
alias gmm='git merge master'
alias gcdf='git clean -df'
alias gp='git push'
alias gco='git commit'
alias gcom='git commit -m'
alias ga='git add'
alias gacom="gaa && gcom"
alias git_current_branch='git symbolic-ref --short HEAD'
alias gpuo='git push -u origin $(git_current_branch)'
alias gclog='git clog'

# use exa when its installed by alternative of ls
if type "exa" > /dev/null 2>&1; then
    alias ls=exa
fi

# use bat if it exists
if type "bat" > /dev/null 2>&1; then
    alias less=bat
fi


[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# pet regist alias
function prev() {
  PREV=$(fc -lrn | head -n 1)
  sh -c "pet new `printf %q "$PREV"`"
}

function gi() { curl -L -s https://www.gitignore.io/api/$@ ;}

# added by travis gem
[ -f /home/hibikine/.travis/travis.sh ] && source /home/hibikine/.travis/travis.sh


[[ -z "$TMUX" && -n "$USE_TMUX" ]] && {
    [[ -n "$ATTACH_ONLY" ]] && {
        tmux a 2>/dev/null || {
            cd && exec tmux
        }
        exit
    }

    tmux new-window -c "$PWD" 2>/dev/null && exec tmux a
    exec tmux
}

export YVM_DIR="${HOME}/.yvm"
[ -r $YVM_DIR/yvm.sh ] && . $YVM_DIR/yvm.sh
[[ -s "/home/hibikine/.gvm/scripts/gvm" ]] && source "/home/hibikine/.gvm/scripts/gvm"

# added by travis gem
[ -f $HOME/.travis/travis.sh ] && source $HOME/.travis/travis.sh


#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="/home/hibikine/.sdkman"
[[ -s "/home/hibikine/.sdkman/bin/sdkman-init.sh" ]] && source "/home/hibikine/.sdkman/bin/sdkman-init.sh"

# The next line updates PATH for the Google Cloud SDK.
if [ -f "$HOME/google-cloud-sdk/path.zsh.inc" ]; then
    source "$HOME/google-cloud-sdk/path.zsh.inc";
elif [ -f "/snap/google-cloud-sdk/current/path.zsh.inc" ]; then
    source "/snap/google-cloud-sdk/current/path.zsh.inc"
fi

# The next line enables shell command completion for gcloud.
if [ -f "$HOME/google-cloud-sdk/completion.zsh.inc" ]; then
    source "$HOME/google-cloud-sdk/completion.zsh.inc";
elif [ -f "/snap/google-cloud-sdk/current/completion.zsh.inc" ]; then
    source "/snap/google-cloud-sdk/current/completion.zsh.inc"
fi

if [ -f "/usr/local/bin/virtualenvwrapper.sh" ]; then
    export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python3
    source /usr/local/bin/virtualenvwrapper.sh
    export WORKON_HOME=~/.virtualenvs
; fi

# manに色を付ける
man() {
    env LESS_TERMCAP_mb=$'\E[01;31m' \
    LESS_TERMCAP_md=$'\E[01;38;5;74m' \
    LESS_TERMCAP_me=$'\E[0m' \
    LESS_TERMCAP_se=$'\E[0m' \
    LESS_TERMCAP_so=$'\E[38;5;246m' \
    LESS_TERMCAP_ue=$'\E[0m' \
    LESS_TERMCAP_us=$'\E[04;38;5;146m' \
    man "$@"
}

# add explorer alias

if type "explorer" > /dev/null 2>&1; then
    :
else
    if type "xdg-open" > /dev/null 2>&1; then
        alias explorer=xdg-open
    fi
fi

# Load private repository zshrc (if exists)
if [ -f "$HOME/.zshrc-private" ]; then
    source $HOME/.zshrc-private
; fi

[ -f ~/.dotzconfig ] && source ~/.dotzconfig
source $HOME/dotfiles/bin/startsshagent.sh

export GPG_TTY=$(tty)

if [ -d ~/Android ]; then
    export ANDROID_HOME=$HOME/Android
    export ANDROID_SDK_ROOT=$ANDROID_HOME/Sdk
    export PATH=$ANDROID_SDK_ROOT/tools/bin:$PATH
    export PATH=$ANDROID_SDK_ROOT/emulator:$PATH
    export PATH=$ANDROID_SDK_ROOT/platform-tools:$PATH
fi
if [ -d $HOME/.rbenv/bin ]; then
    export PATH="$HOME/.rbenv/bin:$PATH"
    eval "$(rbenv init -)"
fi
