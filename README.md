This intended to serve as a base image which installs both Ruby and a Postgres client. It was created in order to support Rails apps that depend on the `pg_dump` command.

### Sample Docker Compose

```yaml
# docker-compose.test.yml
version: '2'
services:
  # 'sut' means "system under test" and this nomenclature is required for Docker Cloud builds
  sut:
    image: timehop/ruby-pg:1.0.0
    command: 'bash -c "(bundle check || bundle install) && bundle exec rspec spec --colour --format Fuubar --profile --fail-fast"'
    volumes:
      - .:/app
    volumes_from:
      - bundle
    depends_on:
      - postgres
    environment:
      - BUNDLE_PATH=/bundle
      - RAILS_ENV=test
      - DATABASE_HOST=postgres
  postgres:
    image: postgres:9.5.3
    volumes:
      # Put your postgres init scripts in here
      - ./postgres-setup-scripts:/docker-entrypoint-initdb.d
  # The box service is merely a place to mount a persistent volume of gems.
  # See: https://medium.com/@fbzga/how-to-cache-bundle-install-with-docker-7bed453a5800
  bundle:
    image: busybox:latest
    volumes:
      - /bundle
```

### Release notes:

#### v1.0.0
* Base image: ruby:2.1.9
* Installs: libpq-dev, postgresql-client-9.5
* WORKDIR: /app