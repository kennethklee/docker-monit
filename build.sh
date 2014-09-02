#!/bin/bash
set -x
VERSION="${VERSION:-5.8.1}"
ARCH=linux-x64

curl -fL -o monit.tar.gz http://mmonit.com/monit/dist/binary/${VERSION}/monit-${VERSION}-${ARCH}.tar.gz && \
	tar xvf ./monit.tar.gz

mkdir -p monit/{bin,etc/init.d}
cp -v  monit-${VERSION}/bin/monit ./monit/bin/
cp -v monit-${VERSION}/conf/monitrc ./monit/etc/
cp -v init/monit ./monit/etc/init.d

fpm -s dir -C monit  -p / \
    --name monit --version $VERSION \
    --deb-compression gz \
    -t deb .

rm -rf monit monit-${VERSION} monit.tar.gz

if [ -d "/data" ];then
	cp /monit_${VERSION}_amd64.deb /data/
fi

dpkg -i /monit_${VERSION}_amd64.deb


monit "$@" 
