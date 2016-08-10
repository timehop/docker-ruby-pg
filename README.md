This image installs a Postgres client on top of a ruby image in order to support Rails installs that depend on the `pg_dump` command.

### Release notes:

#### v1.0.0
* Base image: ruby:2.1.9
* Installs: libpq-dev, postgresql-client-9.5
* WORKDIR: /app