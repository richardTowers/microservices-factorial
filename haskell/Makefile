.PHONY: default

default:
	docker build -t microservice-factorial .
	docker run microservice-factorial cat /root/.cabal/bin/microservice-factorial > microservice-factorial
