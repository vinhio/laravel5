# Laravel 5.4 and docker image `vinhxike/php5`

Step by step create Laravel 5.4 project from scratch base on docker image `vinhxike/php5`

Need to review docker image at https://hub.docker.com/r/vinhxike/php5 to understand the application environment and PHP plugins pre-installed in the image. 

Docker compose `docker/docker-compose.yml` declared 4 instances:

    - Web instance PHP 5.6.40
    - Database instance MySQL 5.7.35
    - Caching instance Redis 4.3.0
    - MailServer instance Mailhog 1.0.1

## I. Install

### 1. Customize docker image
Each project we have some different settings, package,.... So, we must modify original image `vinhxike/php5` and call `laravel-web`.

Image `laravel-web` will add some development tools `make mc tmux util-linux` and update some deployment setting in folder `docker/local`. Build `laravel-web`:

    #make build
    #docker images | grep laravel5-web

Note: We can update all docker files and rebuild in development phrase.

### 2. Start app 
####a. Start docker

    #make start

    Creating laravel5-mail  ... done
    Creating laravel5-redis ... done
    Creating laravel5-db    ... done
    Creating laravel5-web   ... done


#### b. Check status:
Check via HTTP
- http://localhost:8080/phpinfo.php

Check via Command line:

    #docker ps
    CONTAINER ID   IMAGE                     COMMAND                  CREATED         STATUS                   PORTS                                                                            NAMES
    14146afab62f   laravel5-web              "/init"                  6 minutes ago   Up 6 minutes             0.0.0.0:8080->80/tcp, :::8080->80/tcp, 0.0.0.0:8443->443/tcp, :::8443->443/tcp   laravel5-web
    57d53fe2eff1   mysql:5.7.35              "docker-entrypoint.s…"   6 minutes ago   Up 6 minutes (healthy)   33060/tcp, 0.0.0.0:33060->3306/tcp, :::33060->3306/tcp                           laravel5-db
    398098dd8dfa   redis:4.0.14-alpine3.11   "docker-entrypoint.s…"   6 minutes ago   Up 6 minutes             6379/tcp                                                                         laravel5-redis
    e80c313a79da   mailhog/mailhog:v1.0.1    "MailHog"                6 minutes ago   Up 6 minutes             1025/tcp, 0.0.0.0:8025->8025/tcp, :::8025->8025/tcp                              laravel5-mail

Check Web server environment:

Go into Web instance

    #make shell

Check (Make sure log in to Web instance)

    laravel5-web ~/app $ php -v
    laravel5-web ~/app $ composer -v | grep 'Composer version'

### 3.Install Laravel 5.4

Let keep your PC/Mac refresh with PHP/Composer and stuff for development. So, I don't recommend adding PHP's stuff to your PC/Mac 
. So, Install Laravel inside instance `laravel5-web` is good solution.

Don't for get Go into Web instance (Note: Remember it for each time to add/remove any PHP Composer package)

    #make shell

#### a. Install Laravel stuff:

You should follow step at https://laravel.com/docs/5.4

    #composer create-project --prefer-dist laravel/laravel temp_app "5.4.*"
    #mv -r temp_app/* . && rm -fr temp_app

Check via HTTP
- http://localhost:8080/
