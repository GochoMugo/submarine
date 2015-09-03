#
# networking made easy
#


# modules
msu_require "console"


# pinging to see if we are connected to the internet
# and that a website is up
function online() {
  local hosts
  local host
  local stats

  hosts="$@"
  if [ ! "${1}" ]
  then
    hosts="${SUBMARINE_PING_URL:-duckduckgo.com}"
  fi

  for host in "${hosts}"
  do
    ping -q -c 5 ${host} > /dev/null 2>/dev/null && {
      tick "${host}"
    } || {
      cross "${host}"
    }
  done
}
