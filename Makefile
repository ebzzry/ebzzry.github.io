all:
	sh -x build.sh

resources:
	sh -x build.sh -r

clean:
	rm -rf *.html static
