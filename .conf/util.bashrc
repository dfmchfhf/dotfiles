file=$(basename "$BASH_SOURCE");name=${file%.*};if [[ $SOURCED == *":${name}:"* ]]; then return; fi; export SOURCED="${SOURCED}${name}:";unset file name;

function grokexit() {
  local errno
  if [ $1 -gt 127 ]; then
    errno=$(($1-127))
    case $errno in
       1) echo "SIGHUP";;
       2) echo "SIGINT";;
       3) echo "SIGQUIT";;
       4) echo "SIGILL";;
       5) echo "SIGTRAP";;
       6) echo "SIGABRT";;
       7) echo "SIGBUS";;
       8) echo "SIGFPE";;
       9) echo "SIGKILL";;
      10) echo "SIGUSR1";;
      11) echo "SIGSEGV";;
      12) echo "SIGUSR2";;
      13) echo "SIGPIPE";;
      14) echo "SIGALRM";;
      15) echo "SIGTERM";;
      16) echo "SIGSTKF";;
      17) echo "SIGCHLD";;
      18) echo "SIGCONT";;
      19) echo "SIGSTOP";;
      20) echo "SIGTSTP";;
      21) echo "SIGTTIN";;
      22) echo "SIGTTOU";;
      23) echo "SIGURG";;
      24) echo "SIGXCPU";;
      25) echo "SIGXFSZ";;
      26) echo "SIGVTAL";;
      27) echo "SIGPROF";;
      28) echo "SIGWINCH";;
      29) echo "SIGIO";;
      30) echo "SIGPWR";;
      31) echo "SIGSYS";;
      34) echo "SIGRTMIN";;
      35) echo "SIGRTMIN+1";;
      36) echo "SIGRTMIN+2";;
      37) echo "SIGRTMIN+3";;
      38) echo "SIGRTMIN+4";;
      39) echo "SIGRTMIN+5";;
      40) echo "SIGRTMIN+6";;
      41) echo "SIGRTMIN+7";;
      42) echo "SIGRTMIN+8";;
      43) echo "SIGRTMIN+9";;
      44) echo "SIGRTMIN+10";;
      45) echo "SIGRTMIN+11";;
      46) echo "SIGRTMIN+12";;
      47) echo "SIGRTMIN+13";;
      48) echo "SIGRTMIN+14";;
      49) echo "SIGRTMIN+15";;
      50) echo "SIGRTMAX-14";;
      51) echo "SIGRTMAX-13";;
      52) echo "SIGRTMAX-12";;
      53) echo "SIGRTMAX-11";;
      54) echo "SIGRTMAX-10";;
      55) echo "SIGRTMAX-9";;
      56) echo "SIGRTMAX-8";;
      57) echo "SIGRTMAX-7";;
      58) echo "SIGRTMAX-6";;
      59) echo "SIGRTMAX-5";;
      60) echo "SIGRTMAX-4";;
      61) echo "SIGRTMAX-3";;
      62) echo "SIGRTMAX-2";;
      63) echo "SIGRTMAX-1";;
      64) echo "SIGRTMAX";;
    esac
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
  history | grep "$@" | tac | head -n $limit
}
alias hist?='histsearch'

function colorise() {
  local format opt OPTIND OPTARG esc
  format='%Y-%m-%d:%H.%M.%S'
  while getopts ":t:" opt; do
    case $opt in
      t)
        format=$OPTARG
        ;;
      \?)
        echo "$0: invalid option: -$OPTARG" >&2
        return 1
        ;;
    esac
  done
  esc=$(echo -e -n "\033")
  shift $((OPTIND-1))
  sed -r -e 's/%%/%%!/g' \
         -e 's/%\{(.+),(.+)\}/%{\1}%{,\2}/g' \
         -e "s/%\{#([0-9]+)\}/$esc[38;5;\1m/g" \
         -e "s/%\{,#([0-9]+)\}/$esc[48;5;\1m/g" \
         -e 's/%\{(,?.)\}/%\1/g' \
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
         < <(echo "$@")
}

function exists() {
  command -v "$1" >/dev/null 2>&1
}

if exists python; then
  function pycalc() {
    python -c "import math; print $*"
  }
fi

function nop() {
  return 0
}

function prepend_live() {
  local at_newline char prepend_string noformat format opt OPTIND OPTARG
  noformat=1
  format='%Y-%m-%d:%H.%M.%S'
  while getopts ":ft:" opt; do
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
  while IFS= read -d'' -s -N 1 char; do
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
    printf "$char"
    unset at_newline
    [ "$char" == $'\n' ] && at_newline=1
  done
}
