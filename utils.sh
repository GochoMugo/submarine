#
# Checks if useful utils are installed
#


# modules
msu_require "console"


function check() {
  declare -A utils
  utils["atom"]="https://atom.io/"
  utils["deluged"]="http://dev.deluge-torrent.org/wiki/Download"
  utils["docker"]="http://docs.docker.com/linux/step_one/"
  utils["dropbox"]="https://www.dropbox.com/install"
  utils["gedit"]="https://wiki.gnome.org/Apps/Gedit"
  utils["gemnasium"]="https://github.com/gemnasium/toolbelt"
  utils["gibo"]="https://github.com/simonwhitaker/gibo"
  utils["git"]="https://git-scm.com/"
  utils["go"]="http://golang.org/doc/install"
  utils["go-search"]="https://github.com/tj/go-search"
  utils["gvm"]="https://github.com/moovweb/gvm"
  utils["hg"]="https://mercurial.selenic.com/"
  utils["http"]="https://github.com/jkbrzt/httpie"
  utils["hub"]="https://github.com/github/hub.git"
  utils["hugo"]="http://gohugo.io"
  utils["jekyll"]="http://jekyllrb.com"
  utils["keybase"]="https://github.com/keybase/node-client"
  utils["mongod"]="https://www.mongodb.org/downloads"
  utils["mackup"]="https://github.com/lra/mackup"
  utils["mysql"]="http://www.mysql.com/"
  utils["node"]="https://nodejs.org/download/" # implies `npm`
  utils["nvm"]="https://github.com/creationix/nvm"
  utils["nw"]="http://nwjs.io/"
  utils["physlock"]="https://github.com/muennich/physlock"
  utils["redis-server"]="http://redis.io/download"
  utils["td"]="https://github.com/Swatto/td/"
  utils["tor"]="https://www.torproject.org/"
  utils["travis"]="https://github.com/travis-ci/travis.rb"
  utils["youtube-dl"]="https://rg3.github.io/youtube-dl/"

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
