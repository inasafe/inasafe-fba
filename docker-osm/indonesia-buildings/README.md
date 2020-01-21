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

Simply execute:

```
make up
```

To start the service.
To stop the service use:

```
make down
```

### Verify backend is running

The stack by default will expose postgres database in port 35432 in your local machine.
You can check the database using psql or db admin tools.
It will also expose postgrest and swagger-ui by default in port 3000 and 3080 respectively of your local machine.
So you can check it from the browser to see if the API is available.
The default address to check would be on the http://localhost:3000 and http://localhost:3080.
