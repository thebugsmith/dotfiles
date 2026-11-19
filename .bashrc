#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
PS1='[\u@\h \W]\$ '

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# Added by Antigravity CLI installer
export PATH="/home/cookie/.local/bin:$PATH"

[[ "$TERM_PROGRAM" == "kiro" ]] && . "$(kiro --locate-shell-integration-path bash)"

export MORPHE_HOME="$HOME/.apps/apps/morphe"
export MORPHE_CLI="$MORPHE_HOME/morphe-desktop.jar"
