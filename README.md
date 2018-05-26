# PHP 7.1 - apache - composer

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
docker run -d -p 8090:80 --rm --name php71-apache -v $(pwd)/app/:/var/www/webapp -v $(pwd)/vhost.conf:/etc/apache2/sites-available/000-default.conf -v $(pwd)/php.ini:/etc/php/7.1/apache2/php.ini php71-apache
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
