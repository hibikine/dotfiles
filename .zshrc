unsetopt BG_NICE
source ~/.zplug/init.zsh

zplug "zplug/zplug", hook-build:"zplug --self-manage"
zplug "mafredri/zsh-async"
zplug "sindresorhus/pure"
zplug "rupa/z", use:z.sh
zplug "mollifier/cd-gitroot"
zplug "b4b4r07/enhancd", use:init.sh
zplug "b4b4r07/zsh-gomi", if:"which fzf"
zplug "zsh-users/zsh-syntax-highlighting"
zplug "zsh-users/zsh-autosuggestions"
zplug "zsh-users/zsh-history-substring-search", defer:2
zplug "zsh-users/zsh-completions"
zplug "chrissicool/zsh-256color"
zplug "junegunn/fzf-bin", as:command, from:gh-r, rename-to:fzf
zplug "peco/peco", as:command, from:gh-r, use:"*amd64*"
zplug "mrowa44/emojify", as:command
zplug "stedolan/jq", from:gh-r, as:command, on:b4b4r07/emoji-cli, if:"which jq"
zplug "walesmd/caniuse.plugin.zsh"
zplug "liangguohuan/zsh-dircolors-solarized"
zplug "felixr/docker-zsh-completion"
#zplug "github/hub", use:etc/hub.zsh_completion
#zstyle prompt theme 'pure'
#zplug "modules/history",    from:prezto 
#zplug "modules/utility",    from:prezto 
#zplug "modules/ruby",       from:prezto 
#zplug "modules/ssh",        from:prezto 
#zplug "modules/terminal",   from:prezto 
#zplug "modules/directory",  from:prezto
zplug load --verbose

# PATH settings
export PATH="$PATH:$HOME/.cargo/bin:/usr/local/go/bin:$HOME/.local/bin:$HOME/.rbenv/bin"

if [[ -s "$HOME/src/google-cloud-sdk" ]]; then
    source $HOME/src/google-cloud-sdk/completion.zsh.inc
    source $HOME/src/google-cloud-sdk/path.zsh.inc
fi

# pure config
PURE_PROMPT_SYMBOL=">"

# enhancd config
#export ENHANCD_DISABLE_DOT=1
export ENHANCD_FILTER=fzy:fzf:peco
export GOPATH="$HOME/go"

# Home
WHOAMI=$(whoami)

# Aliases
alias chstartserver="gcloud compute instances start dev-2"
alias chstopserver="gcloud compute instances stop dev-2"
alias cd..="cd .."
alias winsrc="cd /mnt/c/Users/Kage/src/"
alias lasimg="cd /mnt/c/Users/Kage/src/lastyearimages/"
alias webcr="cd /mnt/c/Users/${WHOAMI}/src/webcraft/"
alias winHome="cd /mnt/c/Users/$USER/"
alias owcl="cd /mnt/e/ownCloud/"
alias ch="cd ~/src/cheetah_app/"
alias chdocker="cd ~/src/cheetah_app/web/cheetah_docker/ && docker-compose up -d"
alias chwatch="cd ~/src/cheetah_app/web/ && yarn watch"
alias getmyip="curl inet-ip.info"
alias cdnol="cd /mnt/c/Users/goods/src/nolose-backend"
export PATH="$PATH:$HOME/.cargo/bin:/home/linuxbrew/.linuxbrew/bin:$HOME/.config/yarn/global/node_modules/.bin:$HOME/.local/bin"
alias startdevserver="gcloud compute instances start dev-2"
alias stopdevserver="gcloud compute instances stop dev-2"
alias grep='grep --color'
alias df='df -h'
alias dusc='du -s -c *'

alias untgz='tar -xzvf'
alias untbz='tar -xjvf'

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

# git aliases
alias hyperlog="git log --oneline --graph --decorate=full"
alias gaa='git add --all'
alias gc='git checkout'
alias gcb='git checkout -b'
alias gs='git status'
alias gst='git status'
alias gb='git branch'
alias gcm='git checkout master'
alias gpu='git pull'
alias gpom='git pull origin master'
alias gmm='git merge master'
alias gcdf='git clean -df'
alias gp='git push'
alias gco='git commit'
alias gcom='git commit -m'
alias ga='git add'

# proxy aliases
alias setproxy='git config --global http.proxy ccproxyc.kanagawa-it.ac.jp:10080 && git config --global https.proxy ccproxyc.kanagawa-it.ac.jp:10080 && sed -i -e "s/#ProxyCommand connect -H ccproxyc.kanagawa-it.ac.jp:10080 %h %p/ProxyCommand connect -H ccproxyc.kanagawa-it.ac.jp:10080 %h %p/" ~/.ssh/config && export http_proxy=http://ccproxyc.kanagawa-it.ac.jp:10080 && export https_proxy=http://ccproxyc.kanagawa-it.ac.jp:10080'
alias setdockerproxy='sudo sed -i -e "s/#export http_proxy=http:\/\/ccproxyc.kanagawa-it.ac.jp:10080/export http_proxy=http:\/\/ccproxyc.kanagawa-it.ac.jp:10080/" /etc/default/docker && sudo sed -i -e "s/#export https_proxy=https:\/\/ccproxyc.kanagawa-it.ac.jp:10080/export https_proxy=http:\/\/ccproxyc.kanagawa-it.ac.jp:10080/" /etc/default/docker'
alias unsetproxy='git config --global --unset http.proxy && git config --global --unset https.proxy && sed -i -e "s/ProxyCommand connect -H ccproxyc.kanagawa-it.ac.jp:10080 %h %p/#ProxyCommand connect -H ccproxyc.kanagawa-it.ac.jp:10080 %h %p/" ~/.ssh/config && export http_proxy="" && export https_proxy=""'
alias unsetdockerproxy='sudo sed -i -e "s/export http_proxy=http:\/\/ccproxyc.kanagawa-it.ac.jp:10080/#export http_proxy=http:\/\/ccproxyc.kanagawa-it.ac.jp:10080/" /etc/default/docker && sudo sed -i -e "s/export https_proxy=https:\/\/ccproxyc.kanagawa-it.ac.jp:10080/#export https_proxy=http:\/\/ccproxyc.kanagawa-it.ac.jp:10080/" /etc/default/docker'

[ -f ~/.dotzconfig ] && source ~/.dotzconfig

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

export YVM_DIR=/home/hibikine/.yvm
source /usr/local/bin/yvm
[[ -s "/home/hibikine/.gvm/scripts/gvm" ]] && source "/home/hibikine/.gvm/scripts/gvm"
