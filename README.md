# DMIS
Disaster Management Information Service

## Getting Started

The DMIS application is split into a client and server structure.  The client can be run independently of the server code to make front-end development easier. The docker-compose setup is however made based on running both client and server from the same progress.

# Getting up and running for development

As mentioned above, the project is based on docker compose, which should be able to run straight away by just using `docker-compose up`. The first time you run the project, you will need to do a few things to initiate the database and users:

## Database setup

    docker-compose exec db psql -U postgres -c 'CREATE DATABASE dmis'
    docker-compose exec web bash -c 'python manage.py db upgrade'

## Create admin user account

    docker-compose exec web bash -c 'python manage.py create_admin -u admin -p admin1234'

## Generate the static pages for client side

Note that you can do this on your own computer as well in case you don't wish to do it in the docker `node` container. All you have to do is install node 8.10, and angular cli (which provides the `ng` commandline tool), as well as run the commands from below in the `src/client` folder

    docker-compose run --rm node bash -c 'npm install --include-dev'
    docker-compose run --rm node bash -c 'ng build --aot --prod -op ../server/web/static/dist/en'

### DB migrations
We use [Flask-Migrate](https://flask-migrate.readthedocs.io/en/latest/) to create the database from the migrations directory. Create the database as follows:

```
python manage.py db upgrade
```

Create migration scripts when DB models have been updated as follows:
```
python manage.py db migrate
```

## Running client locally

If you want to just run the client side, with no server, you can do the following:

* Before running you'll need to create a distribution of the client code, that we'll use Flask to serve.  This is done via Angular CLI from the client directory:
    * ```cd client```
    * ```ng build --aot --prod -op ../server/web/static/dist/en```
* Once the distribution has been built, you can run the app from the command line, ensure you have installed all dependencies, as described above, then:
    * ```python manage.py runserver -d```
* To see the app running, point your browser to [http://localhost:5000/](http://localhost:5000/)


### Getting Started with Client Development

### Set-Up

From the command line navigate to the root client directory and run npm install:

```
cd client
npm install
```

### Running the app

#### DMIS Angular Client

This project was generated with [Angular CLI](https://github.com/angular/angular-cli) version 1.1.1.

#### Development server

Run `ng serve` for a dev server. Navigate to `http://localhost:4200/`. The app will automatically reload if you change any of the source files.

#### Code scaffolding

Run `ng generate component component-name` to generate a new component. You can also use `ng generate directive|pipe|service|class|module`.

#### Build

Run `ng build` to build the project. The build artifacts will be stored in the `dist/` directory. Use the `-prod` flag for a production build.

#### Running unit tests

Run `ng test` to execute the unit tests via [Karma](https://karma-runner.github.io).

#### Further help

To get more help on the Angular CLI use `ng help` or go check out the [Angular CLI README](https://github.com/angular/angular-cli/blob/master/README.md).

### Testing the app

TODO
