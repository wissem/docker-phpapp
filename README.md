# Docker PHP App

Basic docker containers to setup a modern PHP app (Symfony2, Laravel, etc).

### Current Stack:
- Debian Jessie
- PHP-FPM 5.6
- MySQL
- nginx
- PHPMyAdmin
- Solr
- Redis
- rabbitmq
- memcached
- scala
- selenuim - firefox

## Installation

1. Place your web app under ```apps/``` and create your the appropriate nginx.conf for your app under ```nginx/``` 

2. Create an ```.env``` file from ```.env.dist```and edit it with your own config

3. Build then run the containers:

```bash
$ make build
```

Then update the hosts parameter in your app config, ie for Symfony2 in app/config/parameters.yml:

```yaml
database_host: mysqldb
... 
solr_host: solr
...
rabbit_mq_host: rabbitmq
```


## Usage

Custom scripts or additional extensions could be added into one of the containers build ( ie: installing more php extension or adding custom aliases.) Also you can add / remove containers.

```bash
$ make ssh container=php
$ php app/console cache:clear
$ composer install
```

```bash
$ make ssh container=memcached
$ memcached -u memcached -d -m 30 -l 127.0.0.1 -p 11211
```

## Troubleshooting

First have a look [here](https://docs.docker.com/docker-for-mac/troubleshoot/).

### docker-compose build is not responding or is way too slow on Mac OS X

- Try adding this line into your ```/etc/hosts```:

```
127.0.0.1 localunixsocket
```

- Run docker inside a linux VM, assign the VM a static ip address and use your IDE to sync files
- Have a look into docker-sync 

### Composer is too slow

- Disable xdebug (inside the container from ```/usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini```)



