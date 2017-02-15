file=$(basename $BASH_SOURCE);name=${file%.*};if [[ $SOURCED == *":${name}:"* ]]; then return; fi; export SOURCED="${SOURCED}${name}:";

source .conf/util.bashrc #grokexit

alias ls="ls --color -F"
alias so="source"

function last_exit() {
  ret=$?
  name=$(grokexit $ret)
  if [ $ret -eq 0 ]; then
    colo=2
  else
    colo=1
  fi
  echo -e "$(tput bold; tput setaf 0)[return: $(tput sgr0; tput setaf $colo)${ret}${name:+ ($name)}$(tput sgr0; tput bold; tput setaf 0)]$(tput sgr0)"
}

export PS1="\$(last_exit)\n\
\[$(tput setaf 6; tput bold; tput setab 4)\][\d \t]\[$(tput sgr0)\] \
\[$(tput setaf 1)\]\u\[$(tput sgr0)\]@\[$(tput setaf 5)\]\h\[$(tput sgr0)\]:\[$(tput setaf 2)\]\w\[$(tput sgr0)\] \
\[$(tput setaf 3)\]\!\[$(tput setaf 6; if [ $EUID -eq 0 ]; then tput rev; fi)\]\$\[$(tput sgr0)\] "

