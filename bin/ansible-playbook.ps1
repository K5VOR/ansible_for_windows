$DOCKER_LOCATION = "$env:userprofile\projects\docker_ansible_windows"
docker-compose -f $DOCKER_LOCATION\docker-compose.yml run --rm ansible ansible-playbook $args
