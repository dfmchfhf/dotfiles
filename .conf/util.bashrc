file=$(basename "$BASH_SOURCE");name=${file%.*};if [[ $SOURCED == *":${name}:"* ]]; then return; fi; export SOURCED="${SOURCED}${name}:";unset file name;

function grokexit() {
  local errno
  if [ $1 -gt 127 ]; then
    errno=$(($1-128))
    if [ $errno -lt 64 ]; then
      echo "SIG$(kill -l ${errno})"
    fi
  else
    case $1 in
      0) echo "SUCCESS";;
      1) echo "FAILURE";;
    esac
  fi
}

function histsearch() {
  local limit opt OPTIND OPTARG
  limit=12
  while getopts ":n:" opt; do
    case $opt in
      n)
        case $OPTARG in
          ''|*[!0-9]*)
            echo "$0: -n expects a number, got: $OPTARG" >&2
            return 1
            ;;
        esac
        limit=$OPTARG
        ;;
      \?)
        echo "$0: invalid option: -$OPTARG" >&2
        return 1
        ;;
    esac
  done
  shift $((OPTIND-1))
  history | head -n -1 | grep "$@" | tac | head -n $limit
}
alias 'hist?'='histsearch'

function colourise() {
  local format opt OPTIND OPTARG esc flags
  format='%Y-%m-%d:%H.%M.%S'
  while getopts ":nt:" opt; do
    case $opt in
      n)
        flags+=' -n'
        ;;
      t)
        format=$OPTARG
        ;;
      \?)
        echo "$0: invalid option: -$OPTARG" >&2
        return 1
        ;;
    esac
  done
  esc="$(echo -e -n "\033")"
  shift $((OPTIND-1))
  sed -r -e 's/%%/%%!/g' \
         -e 's/%\{(.+),(.+)\}/%{\1}%{,\2}/g' \
         -e "s/%\\{#([0-9]+)\\}/$esc[38;5;\\1m/g" \
         -e "s/%\\{,#([0-9]+)\\}/$esc[48;5;\\1m/g" \
         -e 's/%\{(,?[^{}]+)\}/%\1/g' \
         -e "s/%l/$(tput setaf 0)/g" \
         -e "s/%r/$(tput setaf 1)/g" \
         -e "s/%g/$(tput setaf 2)/g" \
         -e "s/%y/$(tput setaf 3)/g" \
         -e "s/%b/$(tput setaf 4)/g" \
         -e "s/%m/$(tput setaf 5)/g" \
         -e "s/%c/$(tput setaf 6)/g" \
         -e "s/%w/$(tput setaf 7)/g" \
         -e "s/%n/$(tput setaf 9)/g" \
         -e "s/%,l/$(tput setab 0)/g" \
         -e "s/%,r/$(tput setab 1)/g" \
         -e "s/%,g/$(tput setab 2)/g" \
         -e "s/%,y/$(tput setab 3)/g" \
         -e "s/%,b/$(tput setab 4)/g" \
         -e "s/%,m/$(tput setab 5)/g" \
         -e "s/%,c/$(tput setab 6)/g" \
         -e "s/%,w/$(tput setab 7)/g" \
         -e "s/%,n/$(tput setab 9)/g" \
         -e "s/%N/$(tput sgr0)/g" \
         -e "s/%r/$(tput rev)/g" \
         -e "s/%d/$(tput dim)/g" \
         -e "s/%D/$(tput bold)/g" \
         -e "s/%u/$(tput smul)/g" \
         -e "s/%U/$(tput rmul)/g" \
         -e "s/%t/$(date +"${format}")/g" \
         -e 's/%%!/%/g' \
         < <(echo ${flags} "$@")
}

function colours() {
  local num_colours
  num_colours=$(tput colors)
  if [ $num_colours -le 256 ]; then
    for i in $(seq 0 ${num_colours}); do
      printf "%4d " ${i}
      tput setab ${i}
      printf "      "
      tput sgr0
      [ $((i%6)) -eq 3 ] && [ $i -ge 15 ] && echo '' || :
    done
  fi
}

function exists() {
  command -v "$1" >/dev/null 2>&1
}

if exists python; then
  function pycalc() {
    python -c "import math; print $*"
  }
fi

alias nop=':'

function prepend_live() {
  local at_newline char prepend_string noformat format opt OPTIND OPTARG
  noformat=1
  format='%Y-%m-%d:%H.%M.%S'
  while getopts ':ft:' opt; do
    case $opt in
      f)
        unset noformat
        ;;
      t)
        format=$OPTARG
        ;;
      \?)
        echo "$0: invalid option: -$OPTARG" >&2
        return 1
        ;;
    esac
  done
  at_newline=1
  while IFS= read -r -d'' -s -N 1 char; do
    if [ $at_newline ]; then
      if [ $noformat ]; then
        prepend_string="$@"
      else
        prepend_string=$(sed -r -e 's/%%/%%!/g' \
                                -e "s/%p/$$/g" \
                                -e "s/%t/$(date +"${format}")/g" \
                                -e 's/%%!/%/g' \
                                < <(echo "$@"))
      fi
      echo -n "$prepend_string"
    fi
    printf "%s" "$char"
    unset at_newline
    [ "$char" == $'\n' ] && at_newline=1
  done
}

function nth() {
  local input max
  max=0
  for l in "$@"; do
    if [ $l -gt $max ]; then
      max=$l
    fi
  done
  input="$(head -n $max)"
  for l in "$@"; do
    head -n $l <<< "${input}" | tail -n 1
  done
}
