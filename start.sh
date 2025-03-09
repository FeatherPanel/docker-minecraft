#!/bin/sh
set -e

IS_INSTALLED=/app/.installed
JAVA_VERSION=${JAVA_VERSION:-$(update-java-alternatives -l | awk '{print $1}' | head -n 1)}

if [ -f "$IS_INSTALLED" ]; then
	# Run pre-init scripts
	if [ -d "/app/pre-init.d" ]; then
		for f in /app/pre-init.d/*; do
			chmod +x "$f"
			if [ -x "$f" ]; then
				"$f"
			fi
		done
	fi

	# Run
	cd /app
	su minecraft -c "./run.sh"
else
	# Create Hierachy
	cd /
	mkdir -p /app/files
	mkdir -p /app/pre-init.d
	touch /app/pre-init.d/dummy.sh
	chmod +x /app/pre-init.d/dummy.sh

	# Default Java Version
	update-java-alternatives -s $JAVA_VERSION

	# Create Run Script
	cd /app
	wget $PANEL_URL/api/v1/games/minecraft/run-script/$GAME_SOFTWARE/$GAME_VERSION/$GAME_VERSION2/$GAME_VERSION3 -q -O run.sh
	chmod +x run.sh

	# Run Installation Script
	cd /app/files
	wget -q -O - $PANEL_URL/api/v1/games/minecraft/install-script/$GAME_SOFTWARE/$GAME_VERSION/$GAME_VERSION2/$GAME_VERSION3 | bash

	# Misc
	echo "eula=true" >eula.txt

	echo "enable-jmx-monitoring=false" >server.properties
	echo "rcon.port=25575" >>server.properties
	echo "level-seed=" >>server.properties
	echo "gamemode=survival" >>server.properties
	echo "enable-command-block=false" >>server.properties
	echo "enable-query=false" >>server.properties
	echo "generator-settings={}" >>server.properties
	echo "enforce-secure-profile=false" >>server.properties
	echo "level-name=world" >>server.properties
	echo "motd=A Minecraft Server" >>server.properties
	echo "query.port=25565" >>server.properties
	echo "pvp=true" >>server.properties
	echo "generate-structures=true" >>server.properties
	echo "max-chained-neighbor-updates=1000000" >>server.properties
	echo "difficulty=easy" >>server.properties
	echo "network-compression-threshold=256" >>server.properties
	echo "max-tick-time=60000" >>server.properties
	echo "require-resource-pack=false" >>server.properties
	echo "use-native-transport=true" >>server.properties
	echo "max-players=20" >>server.properties
	echo "online-mode=true" >>server.properties
	echo "enable-status=true" >>server.properties
	echo "allow-flight=false" >>server.properties
	echo "broadcast-rcon-to-ops=true" >>server.properties
	echo "view-distance=10" >>server.properties
	echo "server-ip=0.0.0.0" >>server.properties
	echo "resource-pack-prompt=" >>server.properties
	echo "allow-nether=true" >>server.properties
	echo "server-port=25565" >>server.properties
	echo "enable-rcon=false" >>server.properties
	echo "sync-chunk-writes=true" >>server.properties
	echo "op-permission-level=4" >>server.properties
	echo "prevent-proxy-connections=false" >>server.properties
	echo "hide-online-players=false" >>server.properties
	echo "resource-pack=" >>server.properties
	echo "entity-broadcast-range-percentage=100" >>server.properties
	echo "simulation-distance=10" >>server.properties
	echo "rcon.password=" >>server.properties
	echo "player-idle-timeout=0" >>server.properties
	echo "force-gamemode=false" >>server.properties
	echo "rate-limit=0" >>server.properties
	echo "hardcore=false" >>server.properties
	echo "white-list=false" >>server.properties
	echo "broadcast-console-to-ops=true" >>server.properties
	echo "spawn-npcs=true" >>server.properties
	echo "previews-chat=false" >>server.properties
	echo "spawn-animals=true" >>server.properties
	echo "function-permission-level=2" >>server.properties
	echo "level-type=minecraft\:normal" >>server.properties
	echo "text-filtering-config=" >>server.properties
	echo "spawn-monsters=true" >>server.properties
	echo "enforce-whitelist=false" >>server.properties
	echo "spawn-protection=16" >>server.properties
	echo "resource-pack-sha1=" >>server.properties
	echo "max-world-size=29999984" >>server.properties

	# Create User
	addgroup --gid 1000 minecraft
	adduser --disabled-password --no-create-home --gecos "" --ingroup minecraft --uid 1000 minecraft
	chown -R minecraft:minecraft /app/files
	chmod +x /app/pre-init.d/*.sh
	chmod +x /app/run.sh

	# Mark As Installed
	touch /app/.installed

	# Run Pre-Init Scripts
	if [ -d "/app/pre-init.d" ]; then
		for f in /app/pre-init.d/*; do
			chmod +x "$f"
			if [ -x "$f" ]; then
				"$f"
			fi
		done
	fi

	# Run
	cd /app
	su minecraft -c "./run.sh"
fi
