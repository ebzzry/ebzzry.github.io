.PHONY: all clean

all:
	@sh build

clean:
	@rm -f *.html
	@rm -rf static
