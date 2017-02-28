#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

export SOURCED=":"
[ -d $(dirname "$BASH_SOURCE")/.conf ] && for f in $(dirname "$BASH_SOURCE")/.conf/*.bashrc; do
  source $f
done

