# Dockerization of App

followed the tutorial found at:
https://docs.docker.com/compose/rails/

the tutorial bootstraps a new rails application without a local
rails and postgres installation. As we already have bootstrapped
the application and used sqlite, we just need to add the pg gem.

## Modifying the Gemfile - here: adding the pg gem

As we already have a rails app running with sqlite, we need to add
the pg gem to the gemfile and then have the container install the
gem:

    docker-compose run web bundle install

and then rebuild the web image:

    docker build .

If you have postgres installed locally, you can also run bundle install
locally and then build and startup the docker containers directly with

    docker-compose up

## Starting and stopping everything

    docker-compose up

and to stop both containers

    docker-compose down

(from another terminal if you haven't started the containers in detached mode, or just hit ctrl-c in the first terminal window)

## Setting up the database

    docker-compose exec imical rails db:create
    docker-compose exec imical rails db:migrate
    docker-compose exec imical rails db:seed

## Opening the bash

    docker-compose exec imical bash

## Caveats

There are drawbacks on developing with docker.
The Rails Directory is mounted into the container by the volumes entry in the docker-compose.yml file:

    volumes:
      - .:/imical

I've been told that this is sometimes slow and even fails to update under
windows - which means the rails server would not pick up changes right away,
and you would need to restart the container.

Thus, it might be an alternative to just have postgres running in a docker
container locally:

## Just run the db within docker

- make the db available by mapping the port in docker-compose.yml
- adjust the db host in config/database.yml from db to localhost
- then run

   docker-compose up db

and start the rails server up on your local machine.
