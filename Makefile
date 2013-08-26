.PHONY: all clean build preview upload

all: preview

clean:
	rm -rm *.html
	rm -rf blog posts feeds

build:
	raco frog -b

preview:
	raco frog -bp

upload:
	git push origin master
	rsync -avz --delete ./ meta.ph:public_html
