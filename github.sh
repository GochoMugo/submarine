#
# for octocats only
#


# modules
msu_require "console"


# module variables
DEPS=
DEFAULT_USERNAME=$(git config --global user.name)


# generate new github tokens
# will be prompted for necessary information
function new_token() {
  ask "username [${DEFAULT_USERNAME}]:" USERNAME
  [ "${USERNAME}" == "" ] && USERNAME=${DEFAULT_USERNAME}
  ask "password:" PASSWORD 1
  ask "comment:" COMMENT
  DEFAULT_SCOPES="public_repo"
  ask "scopes [${DEFAULT_SCOPES}]:" SCOPES
  [ "${SCOPES}" == "" ] && SCOPES=${DEFAULT_SCOPES}
  SCOPES_STRING=
  for scope in ${SCOPES}
  do
    SCOPES_STRING="${SCOPES_STRING}, \"${scope}\""
  done
  curl -s \
    -u ${USERNAME}:${PASSWORD} \
    -X POST https://api.github.com/authorizations \
    --data "{\"scopes\": [$(echo ${SCOPES_STRING} | cut -b 2-)], \
      \"note\": \"${COMMENT}\"}"
}


# cloning from github
# ${1} - shorthand e.g. GochoMugo/submarine (https://github.com/GochoMugo/submarine)
#        or submarine (https://github.com/<your_user>/submarine)
function clone() {
  # sometimes we copy paste urls, so try understand such situations
  if [[ "${1}" =~ .*github\.com.* ]]
  then
    git clone "${1}"
    return $?
  fi

  if [[ "${1}" =~ .*/.* ]]
  then
    git clone https://github.com/${1}.git
  else
    git clone https://github.com/${DEFAULT_USERNAME}/${1}.git
  fi
  return $?
}
