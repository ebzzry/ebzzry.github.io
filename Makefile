.PHONY: all upload build preview

all: watch

upload:
	git push origin master
	rsync -avz --delete ./ meta.ph:public_html

build:
	raco frog -b

serve:
	raco frog -p

watch:
	raco frog -w

