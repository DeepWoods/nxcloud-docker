FROM ubuntu:latest

LABEL maintainer="Rob Asher"
LABEL version="4.7.5.2"
LABEL release-date="2026-07-14"
LABEL source="https://github.com/deepwoods/nxcloud-docker"

ARG VERSION=4.7.5.2

ENV TZ=${TZ:-Etc/UTC}

RUN apt-y update && apt -y upgrade \
  && apt -y install --no-install-recommends dnsutils iputils-ping tzdata ca-certificates curl openjdk-11-jre-headless \
  # 2. Download using build argument
  && curl -L -O "http://nxfilter.org/pub/nxcloud-${VERSION}.deb" \
  # 3. Install the package
  && apt -y install --no-install-recommends "./nxcloud-${VERSION}.deb" \
  # 4. Clean up unnecessary files and decrease image size
  && apt -y clean autoclean \
  && apt -y autoremove \
  && rm -rf "./nxcloud-${VERSION}.deb" /var/lib/apt /var/lib/dpkg /var/lib/cache /var/lib/log \
  && mkdir -p /nxcloud \
  && echo "${VERSION}" > /nxcloud/version.txt

EXPOSE 53/udp 19004/udp 80 443 19002 19003 19004

CMD ["/nxcloud/bin/startup.sh"]
