.PHONY: lint server-init deploy software-update reboot

lint:
	shellcheck *.sh bin/* targets/*.sh targets/lib/*.sh targets/examples/*.sh lib.d/*.sh

server-init:
	./bin/init-server.sh

deploy:
	./bin/deploy.sh

software-update:
	ssh "${SSH_DEST}" ./configuration/run.sh software-update

reboot:
	ssh "${SSH_DEST}" sudo systemctl reboot
