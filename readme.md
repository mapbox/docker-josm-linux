docker-josm-linux
-----------------
Builds a docker image with JOSM and dependencies installed.

### Build

```sh
docker build -t docker-josm-linux .
```

### Run

```sh
docker run -ti --rm \
    -e DISPLAY=$DISPLAY \
    -v /tmp/.X11-unix:/tmp/.X11-unix \
    -v ~/.josm:/home/developer/.josm \
    --net=host -p 8111:8111 \
    docker-josm-linux:latest
```
