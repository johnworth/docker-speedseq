#!/bin/sh

docker rm $(docker ps -notrunc -a -q)
