IF "%~1" == "" GOTO fail
IF "%~1" == "all" GOTO all
IF "%~1" == "run" GOTO run
IF "%~1" == "start" GOTO start
IF "%~1" == "stop" GOTO stop
IF "%~1" == "destroy" GOTO destroy
IF "%~1" == "logs" GOTO logs
IF "%~1" == "shell" GOTO shell
IF "%~1" == "root" GOTO root
IF "%~1" == "ip" GOTO ip
IF "%~1" == "static_install" GOTO static_install
IF "%~1" == "static" GOTO static
IF "%~1" == "static_watch" GOTO static_watch

GOTO:EOF

:all
    docker-compose -f docker/docker-compose.yml build --no-cache --build-arg hostUID=1000 --build-arg hostGID=1000 web
	docker-compose -f docker/docker-compose.yml build --no-cache static
	EXIT

:run
    docker-compose -f docker/docker-compose.yml -p laravel5 up -d web
    EXIT

:start
    docker-compose -f docker/docker-compose.yml -p laravel5 up -d web
    EXIT

:stop
	docker-compose -f docker/docker-compose.yml -p laravel5 kill
	EXIT

:destroy:
	docker-compose -f docker/docker-compose.yml -p laravel5 down
	EXIT

:logs
	docker-compose -f docker/docker-compose.yml -p laravel5 logs -f web
	EXIT

:shell
	docker-compose -f docker/docker-compose.yml -p laravel5 exec --user nginx web bash
	EXIT

:root
	docker-compose -f docker/docker-compose.yml -p laravel5 exec web bash
	EXIT

:ip
	docker inspect laravel5-web | grep \"IPAddress\"
	EXIT

:static_install
	docker run -it -v "PWD:/build" laravel5-static npm --loglevel=error install
	EXIT

:static
	docker run -it -v "PWD:/build" laravel5-static npm --loglevel=error run dev
	EXIT

:static_watch
	docker run -it -v "PWD:/build" laravel5-static npm --loglevel=error run watch
	EXIT

:fail
    Echo "Run command .\make.bat <command>"
    EXIT
