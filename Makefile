.PHONY: all upload build preview

all: watch

upload:
	git push origin master
	rsync -avz --delete ./ meta.ph:public_html

build:
	raco frog -b

preview:
	raco frog -p

buildpreview:
	raco frog -bp

watch:
	raco frog -w
