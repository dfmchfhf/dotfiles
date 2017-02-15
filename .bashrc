#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

#PS1='[\u@\h \W]\$ '

export SOURCED=":"
for f in ./.conf/*.bashrc; do
  source $f
done

