#!/bin/sh

apt-get update --assume-yes&&
    apt-get install --assume-yes curl &&
    curl --output /tmp/vagrant_1.9.3_x86_64.deb https://releases.hashicorp.com/vagrant/1.9.3/vagrant_1.9.3_x86_64.deb?_ga=1.244820492.806233260.1489927479 &&
    apt-get install --assume-yes /tmp/vagrant_1.9.3_x86_64.deb &&
    apt-get update --assume-yes &&
    apt-get clean all