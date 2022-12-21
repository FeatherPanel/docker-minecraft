#!/bin/sh
set -e

FILE=/configured
if [ -f "$FILE" ]; then
    service ssh start
    java -jar /sftp/minecraft/server.jar nogui
else 
    groupadd sftp
    useradd $SFTP_USER
    usermod -a -G sftp $SFTP_USER
    usermod --password $(echo $SFTP_PASSWORD | openssl passwd -1 -stdin) $SFTP_USER
    usermod -d /sftp/minecraft $SFTP_USER
    chown $SFTP_USER:sftp /sftp/minecraft
    chown $SFTP_USER:sftp /sftp/minecraft/*
    chmod 777 /sftp/minecraft
    chmod 777 /sftp/minecraft/*

    service ssh start

    touch /configured

    wget https://resources.featherpanel.ml/minecraft/$MINECRAFT_VERSION/server.jar -O server.jar
    java -jar /sftp/minecraft/server.jar nogui
fi
