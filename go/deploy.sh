#!/bin/bash

set -x

echo "start deploy ${USER}"
GOOS=linux GOARCH=amd64 go build -o isupipe_linux -ldflags "-s -w"
for server in i1; do
  ssh -t $server "sudo systemctl stop isupipe-go"
  scp ./isupipe_linux $server:/home/isucon/webapp/go/isupipe
  ssh -t $server "sudo systemctl start isupipe-go"
done

echo "finish deploy ${USER}"
