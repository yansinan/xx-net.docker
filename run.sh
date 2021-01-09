#!/bin/sh
docker stop xx-net
docker rm xx-net
docker build -t debian/xx-net .
docker run -it --name xx-net --net=nginxNet --restart=always -p 8085:8080 -p 8087:8087 -p 1080:1080 debian/xx-net