# Setup fzf
# ---------
if [[ ! "$PATH" == */home/cookie/.fzf/bin* ]]; then
  PATH="${PATH:+${PATH}:}/home/cookie/.fzf/bin"
fi

eval "$(fzf --bash)"
