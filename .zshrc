source ~/.zplug/init.zsh
zplug "sorin-ionescu/prezto"
zplug "walesmd/caniuse.plugin.zsh"
zplug "b4b4r07/zsh-gomi", if:"which fzf"
zplug load --verbose

#
# Executes commands at the start of an interactive session.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# z
. /usr/local/bin/z.sh

source $HOME/src/google-cloud-sdk/completion.zsh.inc
source $HOME/src/google-cloud-sdk/path.zsh.inc

# Customize to your needs...
PURE_PROMPT_SYMBOL=">"
alias hyperlog="git log --oneline --graph --decorate=full"
alias cd..="cd .."
alias lasimg="cd /mnt/c/Users/Kage/src/lastyearimages/"
alias winHome="cd /mnt/c/Users/$USER/"
alias owcl="cd /mnt/e/ownCloud/"
alias ch="cd ~/src/cheetah_app/"
alias chdocker="cd ~/src/cheetah_app/cheetah_docker/ && docker-compose up -d"
alias chwatch="cd ~/src/cheetah_app/ && yarn watch"
alias getmyip="curl inet-ip.info"
export PATH=$PATH:$HOME/.cargo/bin
alias startdevserver="gcloud compute instances start dev-2"
alias stopdevserver="gcloud compute instaces stop dev-2"


