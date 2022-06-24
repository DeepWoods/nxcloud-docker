# NxCloud #

NxCloud is a fully rebrandable multi-tenancy cloud based DNS filter software by Jahastech. It is developed based on [NxFilter](http://nxfilter.org/p3/) and inherits most of the features of [NxFilter](http://nxfilter.org/p3/).

Container image is based off of Ubuntu:latest minimal with DEB package for NxCloud from [NxFilter](http://nxfilter.org/p3/download/).


### Usage ###

#### Interactive container: ####

```
docker run -it --name nxcloud \
   -p 53:53/udp \
   -p 80:80 \
   -p 443:443 \
   deepwoods/nxcloud:latest
```

#### Detached container with persistent data volumes: ####

```
docker run --rm -d --name nxcloud \
  -v nxconf:/nxcloud/conf \
  -v nxdb:/nxcloud/db \
  -v nxlog:/nxcloud/log \
  -p 53:53/udp \
  -p 80:80 \
  -p 443:443 \
  -p 19002-19004:19002-19004 \
  deepwoods/nxcloud:latest
```
