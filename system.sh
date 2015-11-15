#
# Control the system
#


# modules
msu_require "console"


# shutting down the computer, with ease
# ${1} - duration. After how long to stop the computer.
function down() {
  local duration="${1:-now}"

  # ask for confirmation, if we are shutting down NOW
  if [ "${duration}" == "now" ]
  then
    yes_no "shutdown right now" || return 1
  fi

  sudo shutdown -P ${duration}
}

