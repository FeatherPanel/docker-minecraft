# Minecraft server for FeatherPanel

This is a Docker image for Minecraft servers that are managed by FeatherPanel.

[See on Docker Hub](https://hub.docker.com/r/featherpanel/minecraft)

## Usage

```bash
docker run -d \
    -p 25565:25565 \
    -v XXXXXX:/app \
    -e INSTALL_URL=https://featherpanel.natoune.fr/minecraft/.../install.sh \
    -e RUN_URL=https://featherpanel.natoune.fr/minecraft/.../run.sh \
    -e JAVA_VERSION=temurin-XX-jre-amd64 \
    -e JAVA_ARGS="-Xms1G -Xmx1G" \
    -l featherpanel.server.id=XXXXXX \
    -l featherpanel.server.owner=XXXXXX \
    -l featherpanel.server.game=minecraft \
    -l featherpanel.server.name="My Minecraft server" \
    -l featherpanel.server.port=25565 \
    -l featherpanel.server.cpu=1 \
    -l featherpanel.server.ram=4096 \
    -l featherpanel.server.disk=1099511627776 \
    --name XXXXXX \
    --restart=unless-stopped \
    featherpanel/minecraft
```

## Environment variables

| Name           | Description               | Allowed values                                                                             |
| -------------- | ------------------------- | ------------------------------------------------------------------------------------------ |
| `INSTALL_URL`  | URL to the install script | https://featherpanel.natoune.fr/minecraft/{VERSION}/install.sh                             |
| `RUN_URL`      | URL to the run script     | https://featherpanel.natoune.fr/minecraft/{VERSION}/run.sh                                 |
| `JAVA_VERSION` | Java version to use       | `temurin-8-jre-amd64` `temurin-11-jre-amd64` `temurin-17-jre-amd64` `temurin-21-jre-amd64` |

## Labels

| Name                        | Description  | Allowed values |
| --------------------------- | ------------ | -------------- |
| `featherpanel.server.id`    | Server ID    | UUID           |
| `featherpanel.server.owner` | Server owner | Username       |
| `featherpanel.server.game`  | Server game  | minecraft      |
| `featherpanel.server.name`  | Server name  | String         |
| `featherpanel.server.port`  | Server port  | Integer        |
| `featherpanel.server.cpu`   | Server CPU   | Integer        |
| `featherpanel.server.ram`   | Server RAM   | Integer        |
| `featherpanel.server.disk`  | Server disk  | Integer        |

## License

This project is licensed under the MIT license. See the [LICENSE.md](LICENSE.md) file for more information.
