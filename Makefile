.PHONY: lint mullvad-conf mullvad-down mullvad-up server-init deploy software-update reboot

lint:
	shellcheck *.sh bin/* targets/*.sh targets/lib/*.sh targets/examples/*.sh lib.d/*.sh

mullvad-conf:
	./bin/upload-mullvad.sh

mullvad-down:
	false

mullvad-up:
	ssh "${SSH_DEST}" ./configuration/run.sh mullvad-up

server-init:
	./bin/init-server.sh

deploy:
	./bin/deploy.sh

software-update:
	ssh "${SSH_DEST}" ./configuration/run.sh software-update

reboot:
	ssh "${SSH_DEST}" sudo systemctl reboot
