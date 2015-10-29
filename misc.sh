#
# Miscellaneous operations
#
# References:
# * https://github.com/alex-cory/fasthacks
#


# modules
msu_require "console"


# extracting archives
function extract() {
  if [ -f "$1" ] ; then
    case $1 in
      *.tar.bz2)   tar xvjf "$1"     ;;
      *.tar.gz)    tar xvzf "$1"     ;;
      *.bz2)       bunzip2 "$1"      ;;
      *.rar)       unrar x "$1"      ;;
      *.gz)        gunzip "$1"       ;;
      *.tar)       tar xvf "$1"      ;;
      *.tbz2)      tar xvjf "$1"     ;;
      *.tgz)       tar xvzf "$1"     ;;
      *.zip)       unzip "$1"        ;;
      *.Z)         uncompress "$1"   ;;
      *.7z)        7z x "$1"         ;;
      *)           error "'$1' cannot be extracted via >extract<" ;;
    esac
  else
    error "'$1' is not a valid file!"
  fi
}


# Create a ZIP archive of a file or folder.
function makezip() {
  zip -r "${1}.zip" "${1}"
}
