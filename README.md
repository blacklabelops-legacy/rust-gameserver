# Dockerized Rust Game Server

This is an extension of [Didstopia/rust-server](https://github.com/Didstopia/rust-server)

He wrote an tutorial on how to use this image: [Didstopia's Image Tutorial](https://rust.didscraft.com/rust-server-on-linux-using-docker/)

# Let's Get Started

This repository offers a docker-compose quick startup:

You can start a rust server simply by typing:

~~~~
$ docker-compose up -d
~~~~

> Server's configuration is stored inside the repositories docker-compose file.

# Restarting The Server

Server starts are executed as follows:

~~~~
$ docker-compose restart
~~~~

> Will restart rust container.

Best practise: Saving the map before the restart:

~~~~
$ docker-compose exec rust rcon save
~~~~

> Standard rust rcon command for server save.

# Serve Wipe Procedure

1. Stop the server.
1. Delete map files.
1. Start the server.

~~~~
$ docker-compose stop
$ docker-compose exec rust bash -c "rm -f /steamcmd/rust/server/docker/*.sav /steamcmd/rust/server/docker/*.map"
$ docker-compose start
~~~~

> Warning: Wipe is permanent, you will lose your map data!

Best Practise: Saving the map and warning players for server wipe:

~~~~
$ docker-compose exec rust rcon say "Server Wipe In 5 Minutes!"
$ docker-compose exec rust rcon save
~~~~

More Best Practise: Update docker image before restart:

1. Delete the old container.
1. Update the image.
1. Start the image.

~~~~
$ docker-compose rm
$ docker-composel pull
$ docker-compose up -d
~~~~

# Server Logs

You can see the server log by typing:

~~~~
$ docker-compose logs -f
~~~~

# Server Administration

Entering the server's console for administration purposes:

~~~~
$ docker-compose exec rust -it bash
~~~~

# Multiple Servers

You can start multiple server with multiple docker-compose files and by adjusting the server's port and rcon port.

Server's standard ports: 28015 and 28016.

1. Make a copy of your docker-compose file.
1. Change the port inside the docker-compose file. We use ports 28115 and 28116 in our example.
1. Change the container's name.
1. Change the container's volume name.
1. Start the server on different ports.

You will have to adjust the server's start command:

~~~~
- 'RUST_SERVER_STARTUP_ARGUMENTS=-batchmode -load +server.secure 1 +server.port 28115'
~~~~

Also adjust the server's rcon port:

~~~~
- 'RUST_RCON_PORT=28116'
~~~~

Rename the container:

~~~~
container_name: rust2
~~~~

Rename the container's volume:

~~~~
volumes:
  rust2_data:
    external: false
~~~~

Start the new server:

~~~~
$ docker-compose up -d
~~~~

# Install Plugin

You can install plugins:

1. Activate oxide inside image with environment variable `RUST_OXIDE_ENABLED`.
1. Download your desired plugin.
1. Place the plugin file inside the directory `plugins`.
1. Copy the file to the oxide plugin folder of your running server.

~~~~
$ docker cp plugins rust:/steamcmd/rust/oxide
~~~~

> Will copy all plugins from local folder `plugins` to server's plugin directory `/steamcmd/rust/oxide/plugins`.
> Note: All files will be overwritten. Restart the server afterwards.

# Backups

You can either do full server backups or just saving the server's configuration and map.

This example uses the image blacklabelops/volumerize. More information and commands can be found here: [blacklabelops/volumrize](https://github.com/blacklabelops/volumerize)

## Full Backups

Example: Full backup of binaries, plugins, player data and maps.

~~~~
$ docker run -d \
    --name volumerize \
    -v rustgameserver_rust_data:/source \
    -v backup_volume:/backup \
    -e "VOLUMERIZE_SOURCE=/source" \
    -e "VOLUMERIZE_TARGET=file:///backup" \
    blacklabelops/volumerize
~~~~

> The container is pre-configured for automatic backups at 4am. Rust server will not be stopped!

Doing a manual backup:

~~~~
$ docker exec volumerize backup
~~~~

> Will trigger the backup routine manually.

## Partial Backup Server Data

Example: Minimal backup of player data and maps.

~~~~
$ docker run -d \
    --name volumerize \
    -v rustgameserver_rust_data:/source \
    -v backup_volume:/backup \
    -e "VOLUMERIZE_SOURCE=/source/server" \
    -e "VOLUMERIZE_TARGET=file:///backup" \
    blacklabelops/volumerize
~~~~

> The container is pre-configured for automatic backups at 4am. Rust server will not be stopped!

## Backups Restore

You can restore the latest backup with the command:

~~~~
$ docker exec volumerize restore
~~~~

> Will restore the server from the backup!
> Note: Will overwrite all destination files!
