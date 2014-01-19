#!/bin/sh
# Simple script to update the dnsmasq files from git

# CONFIGURE THIS TO YOUR GIT DIRECTORY
GIT_REPO=/home/ffdnsmasq/dnsmasq

# CONFIGURE THIS TO THE USER TO RUN THE GIT COMMANDS AS
USER=ffdnsmasq

cd $GIT_REPO

su -c "git pull" $USER

if ! cmp $GIT_REPO/rules /etc/dnsmasq.d/rules >/dev/null 2>&1 || ! cmp $GIT_REPO/general /etc/dnsmasq.d/general >/dev/null 2>&1 ;
then
    cp $GIT_REPO/rules /etc/dnsmasq.d/rules
    cp $GIT_REPO/general /etc/dnsmasq.d/general

    /usr/sbin/service dnsmasq restart
fi

