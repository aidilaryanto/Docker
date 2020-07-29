#!/usr/bin/env bash

exit_script()
{
echo "Build was killed!"
sendTG "Docker image build was killed!"
}

trap exit_script SIGINT SIGTERM

function sendTG() {
    curl -s "https://api.telegram.org/bot${TELEGRAM_TOKEN}/sendmessage" --data "text=${*}&chat_id=-1001464778174&parse_mode=Markdown"
}

sendTG "\`Docker image is being updated!\`"

docker build . -t aidilaryanto/projectdils:slim-buster
echo "$DOCKER_PASSWORD" | docker login -u "$DOCKER_USERNAME" --password-stdin
docker push aidilaryanto/projectdils:slim-buster

sendTG "\`Images has been successfully pushed to Docker\` %0ATAGS: [Slim-Buster](https://hub.docker.com/r/aidilaryanto/projectdils)"
