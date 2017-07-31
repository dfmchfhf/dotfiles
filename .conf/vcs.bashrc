file=$(basename "$BASH_SOURCE");name=${file%.*};if [[ $SOURCED == *":${name}:"* ]]; then return; fi; export SOURCED="${SOURCED}${name}:";unset file name;

# git
GIT_PS1_SHOWDIRTYSTATE=1
GIT_PS1_SHOWUPSTREAM=auto
GIT_PS1_SHOWSTASHSTATE=1

export GITEDITOR=vim

# hg
# assuming hg-prompt is installed!
function __hg_root() {
  (
    d=$(pwd -P)
    while [[ "$d" != '/' ]]; do # root should not be a hg directory!
      [ -e "$d/.hg" ] && echo -n "$d" && exit 0
      cd -P "$d/.."
      d=$(pwd -P)
    done
    exit 1
  )
  return $?
}

function __hg_ps1() {
  local hg_root hg_bookmark hg_ps1 hg_status
  if hg_root=$(__hg_root); then
    if [ -e "${hg_root}/.hg/bookmarks.current" ]; then
      hg_bookmark="bo:$(cat "${hg_root}/.hg/bookmarks.current")"
    else
      hg_bookmark="br:$(cat "${hg_root}/.hg/branch")"
    fi

    if [ -d "${hg_root}/.hg/shelved" ] && [ -n "$(ls -A ${hg_root}/.hg/shelved)" ]; then
      hg_status="${hg_status}\$"
    fi

    hg_ps1="${hg_bookmark}${hg_status:+ ${hg_status}}"
    printf -- "${1:- (%s)}" "$hg_ps1"
  fi
}

export HGEDITOR=vim

function __merged_repo_ps1() {
  __git_ps1 " (git: %s)"
  __hg_ps1 " (hg: %s)"
}

if [ $(tput colors) -gt 16 ]; then
function __merged_repo_ps1_colour() {
  __git_ps1 " \001$(tput setaf 154; tput setab 22)\002(git: %s)\001$(tput sgr0)\002"
  __hg_ps1 " \001$(tput setaf 253; tput setab 237)\002(hg: %s)\001$(tput sgr0)\002"
}
else
function __merged_repo_ps1_colour() {
  __git_ps1 " \001$(tput setaf 7)\002(git: %s)\001$(tput sgr0)\002"
  __hg_ps1 " \001$(tput setaf 7)\002(hg: %s)\001$(tput sgr0)\002"
}
fi
