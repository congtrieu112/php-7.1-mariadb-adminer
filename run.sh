#!/bin/bash
sudo docker run -d -p 8090:80 --rm --name php71-apache -v $(pwd)/app/:/var/www/webapp -v $(pwd)/vhost.conf:/etc/apache2/sites-available/000-default.conf -v $(pwd)/php.ini:/etc/php/7.1/apache2/php.ini php71-apache

