file=$(basename "$BASH_SOURCE");name=${file%.*};if [[ $SOURCED == *":${name}:"* ]]; then return; fi; export SOURCED="${SOURCED}${name}:";unset file name;

source "$(dirname "$BASH_SOURCE")/util.bashrc" #grokexit
source "$(dirname "$BASH_SOURCE")/vcs.bashrc"

alias ls="ls --color -F"
alias lsa="ls -al"
alias so="source"
alias :e="vim"

LS_COLORS=$(cat $(dirname "$BASH_SOURCE")/lscolors | cut -f1 -d'#' | paste -sd: - | tr -s : | tr -d ' ')

function pretty_exit_code() {
  local ret name colo
  ret=$1
  name=$(grokexit $ret)
  if [ $ret -eq 0 ]; then
    colo=2
  else
    colo=1
  fi
  echo -e "$(tput sgr0; tput bold; tput setaf 0)[return: $(tput sgr0; tput setaf $colo)${ret}${name:+ ($name)}$(tput sgr0; tput bold; tput setaf 0)]$(tput sgr0)"
}

export PROMPT_COMMAND="pretty_exit_code \$? 1>&2"
if [ $(tput colors) -le 16 ]; then
  export PS1="\
\[$(tput setaf 6; tput bold; tput setab 4)\][\d \t]\[$(tput sgr0)\] \[$(tput setaf 3)\]{$SHLVL}\[$(tput sgr0)\] \
\[$(tput setaf 1)\]\u\[$(tput sgr0)\]@\[$(tput setaf 5)\]\H\[$(tput sgr0)\]:\[$(tput setaf 2)\]\w\[$(tput setaf 7)\]\$(__merged_repo_ps1)\[$(tput sgr0)\] \
\[$(tput setaf 3)\]\!\[\$(tput setaf 6; [ \$EUID -eq 0 ] && tput rev)\]\$\[$(tput sgr0)\] "
else
  export PS1="\
\[$(tput setaf 48; tput setab 18)\][\d \t]\[$(tput sgr0)\] \[$(tput setaf 184; tput setab 58)\]{$SHLVL}\[$(tput sgr0)\] \
\[$(tput setaf 1)\]\u\[$(tput sgr0)\]@\[$(tput setaf 5)\]\H\[$(tput sgr0)\]:\[$(tput setaf 2)\]\w\[$(tput sgr0)\]\$(__merged_repo_ps1_colour)\[$(tput sgr0)\] \
\[$(tput setaf 3)\]\!\[\$(tput setaf 6; [ \$EUID -eq 0 ] && tput rev)\]\$\[$(tput sgr0)\] "
fi

export HISTSIZE=10000
unset HISTFILESIZE
shopt -s histverify
CDPATH=":.:~:"

case $TERM in
  xterm*)
    echo -n -e "\033]0;terminal ($(tty))\007"
    ;;
esac
