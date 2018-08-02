.PHONY: 
release: 
	git init . ; git remote add origin https://github.com/vxe/home.git; git pull origin master; rm -rf .git Dockerfile; cp Dockerfile.python2 Dockerfile; docker build -t `whoami`/`basename $$PWD | tr '[A-Z]' '[a-z]'` .
clean: 
	find . ! -name Makefile ! -name Dockerfile.python2 ! -name . ! -name .. | xargs rm -rf
rebuild:
	docker build -f Dockerfile.python2 -t `whoami`/`basename $$PWD | tr '[A-Z]' '[a-z]'` .
push:
	docker push vedwin/python2
