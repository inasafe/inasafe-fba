# Prepare Docker OSM backend

## Setup for local testing

This setup is intended for local testing instance.
It will provide you the default settings for limited area (for smaller size to set up).
In order to spin up the backend for local testing (limited area), follow these steps.


### Preparation phase

This phase will do:

- configuration for local environment
- configuration for local docker-compose override
- fetch test resources

Every command will assume you are running it from this directory.

First execute testing preparation scripts 

```
make prepare-integration-tests
```

It will create these custom local files, which should not be committed into the git repo.

- .cache dir
- .postgres-data dir
- docker-osm-settings/custom_settings dir
- .env file
- docker-compose.override.yml file


Use `docker-compose.override.yml` to override default docker-compose behaviour.
By default it will mount volumes into local host bind. You can also modify the services if you know what you are doing (for example, mount extra volumes, or redirect port)

Use `.env` file to override environment variables that are going to be used in docker-compose file

Important keys like `PGRST_SERVER_PROXY_URI` and `PBF_URL` have comments on it to explain what it do.

### Spin up the services

Before you start up the service, first you need to build the service for local development.

```bash
make build
```

Simply execute:

```bash
make up
```

To start the service.
To stop the service use:

```bash
make down
```

If you want to start specific service only, use:

```bash
make up SERVICE=<name>
```

Where `<name>` is the service name defined by docker-compose files.
Some commands like `make logs` can also use SERVICE parameter

Very often, because you are setting up the service for development, you will need to install or run setup scripts from inside the container.
You can use

```bash
make shell SERVICE=<name>
```

to get inside the shell of the SERVICE.
Sometimes you modify the containers, like installing things.
When you do this, remember that if you recreate the service (happens if you do `make down up`), your changes is lost if it was not persisted in your volume.
If this is not what you want, you should commit your container state.

For example use case, after generating the schema, the container now have external python modules installed.
If you recreate the service, you had to reinstall the modules.
To avoid this, you commit the container state of the db service like this:

```bash
docker commit <db container name> <image name>
```

Where, container name is usually `fbf-backend_db_1` if you use our default 
settings, and image name for the container is `local/postgis:11.0-2.5` as 
described in `docker-compose.override.yml`.
This way, when you recreate container `make down up`, it will use the previous state because you already overwrite the image name.
You don't have to reinstall the python modules again.

### Verify backend is running

The stack by default will expose postgres database in port 35432 in your local machine.
You can check the database using psql or db admin tools.
It will also expose postgrest and swagger-ui by default in port 3000 and 3080 respectively of your local machine.
So you can check it from the browser to see if the API is available.
The default address to check would be on the http://localhost:3000 and http://localhost:3080.
