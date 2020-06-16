function cb() {
  local out=""
  local exit_value=1
  if [[ $# -eq 0 ]]; then
    out=`cli-bookmarks`
    exit_value=$?
  else
    out=`cli-bookmarks "$*"`
    exit_value=$?
  fi
  if [[ $exit_value == 0 ]]; then
    cd "$out"
  else
    echo "$out"
  fi
}

function _cliBookmarks() {
  COMPREPLY=(`cli-bookmarks --completion-current ${2} --completion-previous ${3}`)
  return 0
}
complete -o filenames -o nospace -F _cliBookmarks cb
