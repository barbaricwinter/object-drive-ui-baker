#!/bin/sh

vagrant box add --name IE11 "/srv/ie11.box" &&
    cd /opt/docker &&
    vagrant up
