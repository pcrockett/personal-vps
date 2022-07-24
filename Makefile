.PHONY: default lint server-init deploy software-update restart

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

software-update:
	ssh "${SSH_DEST}" ./configuration/run.sh software-update

restart:
	ssh "${SSH_DEST}" sudo systemctl reboot
