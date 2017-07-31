#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

if [ -n "${VTE_VERSION}" ]; then
  if [[ "${TERM}" == 'xterm' ]]; then
    export TERM='xterm-256color'
  fi
fi

export SOURCED=":"
[ -d $(dirname "$BASH_SOURCE")/.conf ] && for f in $(dirname "$BASH_SOURCE")/.conf/*.bashrc; do
  source $f
done

RC_TIME=$(date +"%s")
