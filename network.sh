#
# networking made easy
#


# modules
msu_require "console"


# module variables
DEPS="curl"


# pinging to see if we are connected to the internet
# and that a website is up
#
# ${@} - OPTIONAL. urls to hit
#
# If no arguments are passed, it defaults to ${SUBMARINE_PING_URL}
# If ${SUBMARINE_PING_URL} is not set, it defaults to "duckduckgo.com"
function online() {
  local hosts
  local host

  hosts="$@"
  if [ ! "${1}" ]
  then
    hosts="${SUBMARINE_PING_URL:-duckduckgo.com}"
  fi

  for host in ${hosts}
  do
    ping -q -c 5 ${host} > /dev/null 2>/dev/null && {
      tick "${host}"
    } || {
      cross "${host}"
    }
  done
}


# return my public IP address
function my_ip() {
  echo $(curl -s https://api.ipify.org)
}
