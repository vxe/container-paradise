.PHONY: clean

clean: release
	find . ! -name Makefile ! -name Dockerfile.nginx ! -name . ! -name .. | xargs rm -rf
release: 
	git init . ; git remote add origin https://github.com/vxe/home.git; git pull origin master; rm -rf .git; docker build -f Dockerfile.nginx -t `whoami`/`basename $$PWD | tr '[A-Z]' '[a-z]'` .

docker-build:
	docker build -f Dockerfile.nginx -t `whoami`/`basename $$PWD | tr '[A-Z]' '[a-z]'` .
