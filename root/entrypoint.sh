#!/bin/sh
# This file is part of baker.
#
#    baker is free software: you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation, either version 3 of the License, or
#    (at your option) any later version.
#
#    baker is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.
#
#    You should have received a copy of the GNU General Public License
#    along with baker.  If not, see <http://www.gnu.org/licenses/>.

TSTAMP=$(date -u) &&
    EXPIRY=$(date -u --date "next month")
    HOME=$(docker volume create --label "com.deciphernow.object-drive-ui.expiry=${EXPIRY}") &&
    DOCKER_COMPOSE=$(docker volume create --label "com.deciphernow.object-drive-ui.expiry=${EXPIRY}") &&
    CODE=$(docker volume create --label "com.deciphernow.object-drive-ui.expiry=${EXPIRY}") &&
    docker login --username=${DOCKERHUB_USERNAME} --password=${DOCKERHUB_PASSWORD} &&
    docker pull deciphernow/aac &&
    docker pull deciphernow/gatekeeper &&
    docker pull deciphernow/odrive &&
    docker pull deciphernow/metadatadb &&
    docker pull deciphernow/zk &&
    docker pull deciphernow/dias &&
    AAC_DIGEST=$(docker inspect --format="{{( index .RepoDigests 0)}}" deciphernow/aac:latest) &&
    GATEKEEPER_DIGEST=$(docker inspect --format="{{( index .RepoDigests 0)}}" deciphernow/gatekeeper:latest) &&
    ODRIVE_DIGEST=$(docker inspect --format="{{( index .RepoDigests 0)}}" deciphernow/odrive:latest) &&
    METADATADB_DIGEST=$(docker inspect --format="{{( index .RepoDigests 0)}}" deciphernow/metadatadb:latest) &&
    ZK_DIGEST=$(docker inspect --format="{{( index .RepoDigests 0)}}" deciphernow/zk:latest) &&
    DIAS_DIGEST=$(docker inspect --format="{{( index .RepoDigests 0)}}" deciphernow/dias:latest) &&
    sed \
        -e "s#deciphernow/aac:latest#${AAC_DIGEST}#" \
        -e "s#deciphernow/gatekeeper:latest#${GATEKEEPER_DIGEST}#" \
        -e "s#deciphernow/odrive:latest#${ODRIVE_DIGEST}#" \
        -e "s#deciphernow/metadatadb:latest#${METADATADB_DIGEST}#" \
        -e "s#deciphernow/zk:latest#${ZK_DIGEST}#" \
        -e "s#deciphernow/dias:latest#${DIAS_DIGEST}#" \
        -e "s#\${CODE}#${CODE}#" \
        -e "s#\${HOMEY}#${HOMEY}#" \
        -e "w/docker-compose.yml" \
        /opt/docker/docker-compose.yml &&
    docker \
        run \
        --interactive \
        --tty \
        --rm \
        --volume ${HOMEY}:/home/user \
        --volume ${CODE}:/code \
        --env TITLE \
        --env GITLAB_PRIVATE_TOKEN \
        --env GIT_USER_NAME \
        --env GIT_USER_EMAIL \
        --env GITLAB_USER_ID \
        --env NPM_USERNAME \
        --env NPM_PASSWORD \
        --env NPM_EMAIL \
        --env GITHUB_REGISTRY_TOKEN \
        barbaricwinter/object-drive-ui-oven:0.0.0 &&
    echo \
        docker \
        run \
        --interactive \
        --volume ${DOCKER_COMPOSE}:/docker-compose \
        --volume /var/run/docker.sock:/var/run/docker.sock:ro \
        --workdir /docker-compose \
        --entrypoint bash \
        --env HOMEY=${HOMEY} \
        --env CODE=${CODE} \
        tidyrailroad/docker-compose:0.0.1