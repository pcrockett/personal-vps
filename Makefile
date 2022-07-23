.PHONY: default lint deploy

default:
	./run.sh

lint:
	shellcheck *.sh bin/* targets/*.sh targets/lib/*.sh targets/examples/*.sh lib.d/*.sh

server-init:
	ssh "${SSH_DEST}" git init --initial-branch main ./configuration
	git remote add server "${SSH_DEST}:configuration"
	git push --set-upstream server main:main

deploy:
	./bin/deploy.sh
