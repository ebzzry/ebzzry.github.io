.PHONY: gh meta all

all: gh meta

gh:
	git push origin master

meta:
	rsync -avz --delete ./ meta.ph:public_html
