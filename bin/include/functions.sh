print_title() {
  TITLE=$1
  echo ""
  echo "* $TITLE"
  echo "============================"
}

read_env_var() {
    VAR=$(grep $1 $2 | xargs)
    IFS="=" read -ra VAR <<< "$VAR"
    echo ${VAR[1]}
}

APPLICATION_NAME=$(read_env_var APPLICATION_NAME .env)
APPLICATION_ENV=$(read_env_var APPLICATION_ENV .env)

function get_composition_files_string() {
  if [ "$APPLICATION_ENV" = "prod" ]
  then
	  echo "-f docker-compose.yml"
  fi

  if [ "$APPLICATION_ENV" = "dev" ]
  then
	  echo "-f docker-compose.yml -f docker-compose-dev.yml"
  fi

  if [ ! "$APPLICATION_ENV" = "dev" ] && [ ! "$APPLICATION_ENV" = "prod" ]
  then
	  echo "Undefined environment"
    exit 1;
  fi

}

files_string=$(get_composition_files_string)