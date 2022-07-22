.PHONY: default lint deploy

default:
	./run.sh

lint:
	shellcheck *.sh bin/* targets/*.sh targets/lib/*.sh targets/examples/*.sh lib.d/*.sh

deploy:
	git push server
	ssh de.crockett.network ./configure.sh
