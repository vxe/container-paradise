.PHONY: 
release: 
	git init . ; git remote add origin https://github.com/vxe/home.git; git pull origin master; rm -rf .git Dockerfile; cp Dockerfile.kali Dockerfile; docker build -t `whoami`/`basename $$PWD | tr '[A-Z]' '[a-z]'` .
clean: 
	find . ! -name Makefile ! -name Dockerfile.kali ! -name . ! -name .. | xargs rm -rf
rebuild:
	docker build -f Dockerfile.kali -t `whoami`/`basename $$PWD | tr '[A-Z]' '[a-z]'` .
push:
	docker push vedwin/kali
