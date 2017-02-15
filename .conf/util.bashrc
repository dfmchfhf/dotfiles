file=$(basename $BASH_SOURCE);name=${file%.*};if [[ $SOURCED == *":${name}:"* ]]; then return; fi; export SOURCED="${SOURCED}${name}:";

function grokexit() {
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

function hist?() {
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
