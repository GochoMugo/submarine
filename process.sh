#
# handling processes, with ease
#


# modules
msu_require "console"
msu_require "format"


# module variables
DEPS=


# is this process running
#
# ${@} processes
function running() {
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
#
# ${1} - program to stop
# ${@} - args to program on restart
function restart() {
  pkill -KILL ${1}
  sleep 1
  ${@}
}


# retry command until it exits successfully (for 100 attempts)
#
# [$1] - OPTIONAL. number of times to run commands
# ${@} - command(s) to run
function retry() {
  local cmds
  local -i counter
  local -i max_attempts
  local exit_code
  cmds="$@"
  counter=1
  max_attempts=10
  exit_code=1

  # reference: http://stackoverflow.com/questions/806906/how-do-i-test-if-a-variable-is-a-number-in-bash
  re='^[0-9]+$'
  if [[ "${1}" =~ ${re} ]]
  then
    max_attempts=${1}
    cmds="${@:2}"
  fi

  until [ ${exit_code} -eq 0 ] || [ ${counter} -gt ${max_attempts} ]
  do
    log " *** Attempt #${counter} ***"
    echo
    ${cmds}
    exit_code=$?
    counter+=1
    echo
  done

  echo
  counter=counter-1 # (!) terrible hack to make attempts count accurate
  [ ${exit_code} -eq 0 ] && {
    success "Completed successfully in ${counter} attempts"
  } || {
    error "Exited with non-zero status code (${exit_code}) after ${counter} attempts"
  }

  return ${exit_code}
}
