FROM ubuntu:20.04
FROM eclipse-temurin:17-jre-focal
LABEL maintainer="Feather Panel <contact@featherpanel.ml>"
LABEL version="1.0.0"
LABEL description="Serveur Minecraft et FTP pour Feather Panel"

# Update packages
RUN apt-get update && apt-get upgrade -y

# Install packages
RUN apt-get install -y wget curl nano openjdk-17-jre-headless openssl openssh-server

# Minecraft Server
RUN mkdir -p /sftp/minecraft
WORKDIR /sftp/minecraft
RUN touch /sftp/DO_NOT_UPLOAD_FILES_HERE

RUN echo "eula=true" > eula.txt

RUN echo "enable-jmx-monitoring=false" > server.properties
RUN echo "rcon.port=25575" >> server.properties
RUN echo "level-seed=" >> server.properties
RUN echo "gamemode=survival" >> server.properties
RUN echo "enable-command-block=false" >> server.properties
RUN echo "enable-query=false" >> server.properties
RUN echo "generator-settings={}" >> server.properties
RUN echo "enforce-secure-profile=false" >> server.properties
RUN echo "level-name=world" >> server.properties
RUN echo "motd=A Minecraft Server" >> server.properties
RUN echo "query.port=25565" >> server.properties
RUN echo "pvp=true" >> server.properties
RUN echo "generate-structures=true" >> server.properties
RUN echo "max-chained-neighbor-updates=1000000" >> server.properties
RUN echo "difficulty=easy" >> server.properties
RUN echo "network-compression-threshold=256" >> server.properties
RUN echo "max-tick-time=60000" >> server.properties
RUN echo "require-resource-pack=false" >> server.properties
RUN echo "use-native-transport=true" >> server.properties
RUN echo "max-players=20" >> server.properties
RUN echo "online-mode=true" >> server.properties
RUN echo "enable-status=true" >> server.properties
RUN echo "allow-flight=false" >> server.properties
RUN echo "broadcast-rcon-to-ops=true" >> server.properties
RUN echo "view-distance=10" >> server.properties
RUN echo "server-ip=0.0.0.0" >> server.properties
RUN echo "resource-pack-prompt=" >> server.properties
RUN echo "allow-nether=true" >> server.properties
RUN echo "server-port=25565" >> server.properties
RUN echo "enable-rcon=false" >> server.properties
RUN echo "sync-chunk-writes=true" >> server.properties
RUN echo "op-permission-level=4" >> server.properties
RUN echo "prevent-proxy-connections=false" >> server.properties
RUN echo "hide-online-players=false" >> server.properties
RUN echo "resource-pack=" >> server.properties
RUN echo "entity-broadcast-range-percentage=100" >> server.properties
RUN echo "simulation-distance=10" >> server.properties
RUN echo "rcon.password=" >> server.properties
RUN echo "player-idle-timeout=0" >> server.properties
RUN echo "force-gamemode=false" >> server.properties
RUN echo "rate-limit=0" >> server.properties
RUN echo "hardcore=false" >> server.properties
RUN echo "white-list=false" >> server.properties
RUN echo "broadcast-console-to-ops=true" >> server.properties
RUN echo "spawn-npcs=true" >> server.properties
RUN echo "previews-chat=false" >> server.properties
RUN echo "spawn-animals=true" >> server.properties
RUN echo "function-permission-level=2" >> server.properties
RUN echo "level-type=minecraft\:normal" >> server.properties
RUN echo "text-filtering-config=" >> server.properties
RUN echo "spawn-monsters=true" >> server.properties
RUN echo "enforce-whitelist=false" >> server.properties
RUN echo "spawn-protection=16" >> server.properties
RUN echo "resource-pack-sha1=" >> server.properties
RUN echo "max-world-size=29999984" >> server.properties

# FTP Server
RUN echo "Match Group sftp" >> /etc/ssh/sshd_config
RUN echo "ChrootDirectory /sftp" >> /etc/ssh/sshd_config
RUN echo "X11Forwarding no" >> /etc/ssh/sshd_config
RUN echo "AllowTcpForwarding no" >> /etc/ssh/sshd_config
RUN echo "ForceCommand internal-sftp" >> /etc/ssh/sshd_config

# Run FTP Server at startup
RUN echo "service ssh start" >> /etc/bash.bashrc

# Copy start.sh
COPY start.sh /start.sh

# Expose ports
EXPOSE 25565
EXPOSE 22

# Start Minecraft Server
CMD ["/start.sh"]
