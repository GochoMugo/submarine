#
# Checks if useful utils are installed
#


# modules
msu_require "console"


# mod vars
declare -A utils


utils["deluged"]="http://dev.deluge-torrent.org/wiki/Download"
utils["dropbox"]="https://www.dropbox.com/install"
utils["gedit"]="https://wiki.gnome.org/Apps/Gedit"
utils["gibo"]="https://github.com/simonwhitaker/gibo"
utils["go"]="http://golang.org/doc/install"
utils["go-search"]="https://github.com/tj/go-search"
utils["git"]="https://git-scm.com/"
utils["hg"]="https://mercurial.selenic.com/"
utils["hub"]="https://github.com/github/hub.git"
utils["keybase"]="https://github.com/keybase/node-client"
utils["mongod"]="https://www.mongodb.org/downloads"
utils["mackup"]="https://github.com/lra/mackup"
utils["node"]="https://nodejs.org/download/"
utils["nvm"]="https://github.com/creationix/nvm"
utils["nw"]="http://nwjs.io/"
utils["physlock"]="https://github.com/muennich/physlock"
utils["redis-server"]="http://redis.io/download"
utils["td"]="https://github.com/Swatto/td/"
utils["tor"]="https://www.torproject.org/"
utils["travis"]="https://github.com/travis-ci/travis.rb"
utils["youtube-dl"]="https://rg3.github.io/youtube-dl/"


function check() {
  for util in "${!utils[@]}"
  do
    if [ $(command -v "${util}") ]
    then
      tick "${util} (${utils[${util}]})"
    else
      cross "${util} (${utils[${util}]})"
    fi
  done
}
