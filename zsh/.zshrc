export ZSH="$HOME/.oh-my-zsh"
	
ZSH_THEME="robbyrussell"

source $ZSH/oh-my-zsh.sh
export EDITOR='nvim'
alias vim='nvim'

[ -f "/home/vmodig/.ghcup/env" ] && . "/home/vmodig/.ghcup/env" # ghcup-env
