#
# badges, faster
#


# module variables
DEPS=


# badges for README
function markdown() {
  local username=${1}
  local package=${2}
  local args=${@}
  local node_badge="[![node](https://img.shields.io/node/v/${package}.svg?style=flat-square)](https://www.npmjs.com/package/${package}) "
  local npm_badge="[![npm](https://img.shields.io/npm/v/${package}.svg?style=flat-square)](https://www.npmjs.com/package/${package}) "
  local travis_badge="[![Travis](https://img.shields.io/travis/${username}/${package}.svg?style=flat-square)](https://travis-ci.org/${username}/${package}) "
  local gemnasium_badge="[![Gemnasium](https://img.shields.io/gemnasium/${username}/${package}.svg?style=flat-square)](https://gemnasium.com/${username}/${package}) "
  local coveralls_badge="[![Coveralls](https://img.shields.io/coveralls/${username}/${package}.svg?style=flat-square)](https://coveralls.io/github/${username}/${package}?branch=master) "
  local targets=( node npm travis gemnasium coveralls )
  for target in ${targets[@]}
  do
    local regexp="\s*--no-${target}\s*"
    echo "${args}" | grep -E "${regexp}" > /dev/null 2>&1
    if [ $? -eq 0 ]
      then
      eval "${target}_badge="
    fi
  done
  echo "${node_badge}${npm_badge}${travis_badge}${gemnasium_badge}${coveralls_badge}"
}
