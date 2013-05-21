.PHONY: all upload build preview

all: buildserve

upload:
	git push origin master
	rsync -avz --delete ./ meta.ph:public_html

build:
	raco frog -b

serve:
	raco frog -p

buildserve:
	raco frog -bp

bs: buildserve
