# NxCloud #

## About ##
NxCloud is a fully rebrandable multi-tenancy cloud based DNS filter software by Jahastech. It is developed based on [NxFilter](http://nxfilter.org/p3/) and inherits most of the features of [NxFilter](http://nxfilter.org/p3/).

Container image is based off of Ubuntu:latest minimal with the most current DEB package for NxCloud from [NxFilter](https://nxfilter.org/p3/download/).

## Usage ##

#### Interactive container for testing: ####

```
docker run -it --name nxcloud \
   -p 53:53/udp \
   -p 19004:19004/udp \
   -p 80:80 \
   -p 443:443 \
   -p 19002-19004:19002-19004 \
   deepwoods/nxcloud:latest
```

#### Detached container with persistent data volumes: ####

```
docker run -dt --name nxcloud \
  -e TZ=America/Chicago \
  -v nxcconf:/nxcloud/conf \
  -v nxcdb:/nxcloud/db \
  -v nxclog:/nxcloud/log \
  -p 53:53/udp \
  -p 19004:19004/udp \
  -p 80:80 \
  -p 443:443 \
  -p 19002-19004:19002-19004 \
  deepwoods/nxcloud:latest
```


## Configuration
* The admin GUI URL is http://[DOCKER_HOST_SERVER_IP]/admin
* TZ of the container defaults to UTC unless overridden by setting the environment variable to your locale.  [see List of tz time zones](https://en.wikipedia.org/wiki/List_of_tz_database_time_zones)


---
## Docker-compose example ##

```yaml
version: '3.5'

services:
  nxcloud:
    image: deepwoods/nxcloud:latest
    container_name: nxcloud
    hostname: nxcloud
    restart: unless-stopped
    environment:
      TZ: "America/Chicago"
    volumes:
      - nxcconf:/nxcloud/conf
      - nxclog:/nxcloud/log
      - nxcdb:/nxcloud/db
    ports:
      - 53:53/udp
      - 19004:19004/udp
      - 80:80
      - 443:443
      - 19002-19004:19002-19004
volumes:
  nxcconf:
  nxcdb:
  nxclog:
```

### Useful Commands ###
docker-compose to start and detach container: `docker-compose up -d`

Stop and remove container: `docker-compose down`

Restart a service: `docker-compose restart nxcloud`

View logs: `docker-compose logs`

Open a bash shell on running container name: `docker exec -it nxcloud /bin/bash`

> **Warning**
> Commands below will delete all data volumes not associated with a container!
> 
> Remove container & persistent volumes(clean slate): `docker-compose down && docker volume prune`

## Updating ##
1. Pull the latest container.  `docker pull deepwoods/nxcloud:latest`
2. Stop and remove the current container.  `docker stop nxcloud && docker rm nxcloud `
> **Note** If using docker-compose:  `docker-compose down`
3. Run the new container with the same command from above.  [Detached container](#detached-container-with-persistent-data-volumes)
> **Note** If using docker-compose:  `docker-compose up -d`
4. Make sure that the container is running.  `docker ps`
5. Check the container logs if unable to access the GUI for some reason.  `docker logs nxcloud`
> **Note** If using docker-compose:  `docker-compose logs`
