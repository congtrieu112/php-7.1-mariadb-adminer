# PHP 7.1 - apache - mariadb - adminer

Install php7.1 plus all dependecies, enable PECL repository from ppa:ondrej/php, install composer and "prestissimo" package to speedup the installation of packages.

For development purpose mount the volume under the "app" folder, so the files updated there are reloaded in the container running php.

To override php.ini or vhost.conf mount the files when running the container.

----

## build the Dockerfile

```
docker build -t php71-apache .
```

## run

```
docker-compose up -d
```

----


## run a shell in the container

```
docker exec -it php71-apache bash
```

From here we can use for example:
```
composer install
```
to install dependecies 
