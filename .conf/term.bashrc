file=$(basename "$BASH_SOURCE");name=${file%.*};if [[ $SOURCED == *":${name}:"* ]]; then return; fi; export SOURCED="${SOURCED}${name}:";unset file name;

source .conf/util.bashrc #grokexit

alias ls="ls --color -F"
alias lsa="ls -a"
alias so="source"
alias :e "vim"

LS_COLORS=$(cat $(dirname "$BASH_SOURCE")/lscolors | cut -f1 -d'#' | paste -sd: - | tr -s : | tr -d ' ')

function last_exit() {
  local ret name colo
  ret=$?
  name=$(grokexit $ret)
  if [ $ret -eq 0 ]; then
    colo=2
  else
    colo=1
  fi
  echo -e "$(tput bold; tput setaf 0)[return: $(tput sgr0; tput setaf $colo)${ret}${name:+ ($name)}$(tput sgr0; tput bold; tput setaf 0)]$(tput sgr0)"
}

export PROMPT_COMMAND="last_exit 1>&2"
export PS1="\
\[$(tput setaf 6; tput bold; tput setab 4)\][\d \t]\[$(tput sgr0)\] \
\[$(tput setaf 1)\]\u\[$(tput sgr0)\]@\[$(tput setaf 5)\]\h\[$(tput sgr0)\]:\[$(tput setaf 2)\]\w\[$(tput sgr0)\] \
\[$(tput setaf 3)\]\!\[$(tput setaf 6; if [ $EUID -eq 0 ]; then tput rev; fi)\]\$\[$(tput sgr0)\] "

shopt -s histverify
export CDPATH=":~:"
