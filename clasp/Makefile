.PHONY: 
release: 
	git init . ; git remote add origin https://github.com/vxe/home.git; git pull origin master; rm -rf .git Dockerfile; cp Dockerfile.clasp Dockerfile; docker build  -t `whoami`/`basename $$PWD | tr '[A-Z]' '[a-z]'` .
clean: 
	find . ! -name Makefile ! -name Dockerfile.clasp ! -name . ! -name .. | xargs rm -rf
rebuild:
	docker build -f Dockerfile -t `whoami`/`basename $$PWD | tr '[A-Z]' '[a-z]'` .
push:
	docker push vedwin/clasp
