## About

This is a Docker image for [PlexPy](https://github.com/JonnyWong16/plexpy) - the Python based monitoring and tracking tool for Plex Media Server.

The Docker image currently supports:

* running PlexPy under its __own user__ (not `root`)
* changing of the __UID and GID__ for the PlexPy user
* support for OpenSSL / HTTPS encryption

## Run

### Run via Docker CLI client

To run the PlexPy container you can execute:

```bash
docker run --name plexpy -v <datadir path>:/datadir -p 8181:8181 dbarton/plexpy
```

Open a browser and point it to [http://my-docker-host:8181](http://my-docker-host:8181)

### Run via Docker Compose

You can also run the PlexPy container by using [Docker Compose](https://www.docker.com/docker-compose).

If you've cloned the [git repository](https://github.com/domibarton/docker-plexpy) you can build and run the Docker container locally (without the Docker Hub):

```bash
docker-compose up -d
```

If you want to use the Docker Hub image within your existing Docker Compose file you can use the following YAML snippet:

```yaml
plexpy:
    image: "dbarton/plexpy"
    container_name: "plexpy"
    volumes:
        - "<datadir path>:/datadir"
    ports:
        - "8181:8181"
    restart: always
```

## Configuration

### Volumes

Please mount the following volumes inside your PlexPy container:

* `/datadir`: Holds all the PlexPy data files (e.g. config, database)

You might also want to mount the `Logs` directory of your Plex server into the container, in case you want to have access to the logs.

### Configuration file

By default the PlexPy configuration is located on `/datadir/config.ini`.
If you want to change this you've to set the `CONFIG` environment variable, for example:

```
CONFIG=/datadir/plexpy.ini
```

### UID and GID

By default PlexPy runs with user ID and group ID `666`.
If you want to run PlexPy with different ID's you've to set the `PLEXPY_UID` and/or `PLEXPY_GID` environment variables, for example:

```
PLEXPY_UID=1234
PLEXPY_GID=1234
```
