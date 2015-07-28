#
# services, yo!
#


# modules
msu_require "console"


# module variables
DEPS="mongod redis-server"
SERVICES_ROOT=${HOME}/services


# list which services are running
function running() {
  local my_services="redis mongo"
  for service in ${my_services}
  do
    # started by submarine
    local pid_file=${SERVICES_ROOT}/pid/${service}.pid
    local pid=
    if [ -f ${pid_file} ]
    then
      pid=$(cat ${pid_file})
      if [ "$(ps aux | grep ${pid} | grep ${service})" ]
      then
        tick "${service} [${pid}]"
      else
        rm ${pid_file}
        cross "${service} (not yet started by submarine)"
      fi
    fi
    # started by someone else
    local others=$(ps aux | grep ${service} | grep -Ev "${pid:-grep}|grep" | grep -Eo "^[^\ ]+\s+[0-9]+\s+" | grep -Eo "[0-9]+" | tr '\n' ' ')
    for other in ${others}
    do
      tick "${service} [${other}] (started by another program)"
    done
  done
}


# init
function init() {
  if [ -f ${SERVICES_ROOT}/pid/${1}.pid ]
  then
    error "${1} service already started"
    return 1
  fi
  mkdir -p ${SERVICES_ROOT}/conf
  mkdir -p ${SERVICES_ROOT}/log
  mkdir -p ${SERVICES_ROOT}/pid
}


# stop a service
function stop_service() {
  if [ ! -f ${SERVICES_ROOT}/pid/${1}.pid ]
  then
    error "${1} service does not seem to be started"
    return 1
  fi
  local pid=$(cat ${SERVICES_ROOT}/pid/${1}.pid)
  kill ${pid}
  rm ${SERVICES_ROOT}/pid/${1}.pid
  rm ${SERVICES_ROOT}/log/${1}.log
  success "${1} stopped"
}


# starting mongodb
function start_mongo() {
  init "mongo"
  local mongo_root=${SERVICES_ROOT}/mongo
  local conf_file=${SERVICES_ROOT}/conf/mongo.conf
  touch ${conf_file}
  mkdir -p ${mongo_root}
  mongod \
    --config ${conf_file} \
    --dbpath ${mongo_root} \
    --fork \
    --pidfilepath ${SERVICES_ROOT}/pid/mongo.pid \
    --logpath ${SERVICES_ROOT}/log/mongo.log
  [ $? -eq 0 ] && success "mongo started" || error "mongo failed to start"
}


# stop mongodb
function stop_mongo() {
  stop_service "mongo"
}


# start redis-server
function start_redis() {
  init "redis"
  local redis_root=${SERVICES_ROOT}/redis
  local conf_file=${SERVICES_ROOT}/conf/redis.conf
  [ -f ${conf_file} ] || conf_file=
  mkdir -p ${redis_root}
  cd ${redis_root}
  redis-server ${conf_file} \
    --daemonize yes \
    --pidfile ${SERVICES_ROOT}/pid/redis.pid \
    --logfile ${SERVICES_ROOT}/log/redis.log
  [ $? -eq 0 ] && success "redis started" || error "redis failed to start"
}


# stop redis server
function stop_redis() {
  stop_service "redis"
}
