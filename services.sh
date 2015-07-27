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
  local services=$(ls ${SERVICES_ROOT}/pid | grep -Eo "^[a-Z]+")
  for service in ${services}
  do
    list ${service}
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
