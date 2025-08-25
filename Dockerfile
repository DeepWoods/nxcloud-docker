FROM ubuntu:latest

LABEL maintainer="Rob Asher"
LABEL version="4.7.3.2"
LABEL release-date="2025-08-25"
LABEL source="https://github.com/deepwoods/nxcloud-docker"

ENV TZ=${TZ:-Etc/UTC}

RUN apt -y update && apt -y upgrade \
  && apt -y install --no-install-recommends dnsutils iputils-ping tzdata curl openjdk-11-jre-headless \
  && curl $(printf ' -O http://nxfilter.org/pub/nxcloud-%s.deb' $(curl https://nxfilter.org/curnxc.php)) \
  && apt -y install --no-install-recommends ./$(printf 'nxcloud-%s.deb' $(curl https://nxfilter.org/curnxc.php)) \
  && apt -y clean autoclean \
  && apt -y autoremove \
  && rm -rf ./$(printf 'nxcloud-%s.deb' $(curl https://nxfilter.org/curnxc.php)) \
  && rm -rf /var/lib/apt && rm -rf /var/lib/dpkg && rm -rf /var/lib/cache && rm -rf /var/lib/log \
  && echo "$(curl https://nxfilter.org/curnxc.php)" > /nxcloud/version.txt

EXPOSE 53/udp 19004/udp 80 443 19002 19003 19004

CMD ["/nxcloud/bin/startup.sh"]
