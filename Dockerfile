FROM ubuntu:22.04
LABEL maintainer="Feather Panel <featherpanel@natanchiodi.fr>"
LABEL version="1.0.1"
LABEL description="Minecraft server for FeatherPanel"

# Install dependencies
RUN apt-get update -y && \
	apt-get upgrade -y && \
	apt-get install -qq -y wget curl unzip jq gnupg2 && \
	wget -O adoptium.asc https://packages.adoptium.net/artifactory/api/gpg/key/public && \
	apt-key add adoptium.asc && \
	echo "deb https://packages.adoptium.net/artifactory/deb $(awk -F= '/^VERSION_CODENAME/{print$2}' /etc/os-release) main" | tee /etc/apt/sources.list.d/adoptium.list && \
	apt-get update -y && \
	apt-get install -qq -y temurin-8-jre temurin-11-jre temurin-17-jre temurin-21-jre && \
	apt-get clean && \
	rm -rf /var/lib/apt/lists/*

# Copy start.sh
COPY start.sh /start.sh
RUN chmod +x /start.sh

# Start Configuration or Server
CMD ["/start.sh"]
