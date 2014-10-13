all: build

clean:
	rm -rm *.html
	rm -rf blog posts feeds

build:
	raco frog -b

upload:
	git push origin master
	rsync -avz --delete ./ meta.ph:public_html
