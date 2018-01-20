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

# Customize to your needs...
PURE_PROMPT_SYMBOL=">"
alias hyperlog="git log --oneline --graph --decorate=full"
alias cd..="cd .."
alias lasimg="cd /mnt/c/Users/Kage/src/lastyearimages/"

