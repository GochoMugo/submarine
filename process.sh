#
# handling processes, with ease
#


# modules
msu_require "format"


# module variables
DEPS=


# is this process running
# ${@} processes
running() {
  local process
  declare -i num
  for process in "$@"
  do
    num=$(ps -ef | grep -E "\ ${process}\$|\/${process}\/|\/${process}\$" | grep -Ev "msu|submarine|grep" | wc -l)
    [ ${num} -gt 0 ] && {
      local pluralize_is="is"
      local pluralize_process="process"
      if [ ${num} -gt 1 ]
      then
        pluralize_is="are"
        pluralize_process="processes"
      fi
      echo -e "${clr_white}${num} ${process}${clr_reset} ${pluralize_process} ${pluralize_is} running"
    } || {
      echo -e "${clr_white}${process}${clr_reset} ${txt_underline}not${txt_normal} running!"
    }
  done
}


# forcibly restart a process
restart() {
  pkill -KILL ${1}
  sleep 1
  ${@}
}
