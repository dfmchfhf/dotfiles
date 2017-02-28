file=$(basename "$BASH_SOURCE");name=${file%.*};if [[ $SOURCED == *":${name}:"* ]]; then return; fi; export SOURCED="${SOURCED}${name}:";unset file name;

alias tmux='tmux -2'
