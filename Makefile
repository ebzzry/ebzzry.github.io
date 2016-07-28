.PHONY: all clean

%.html: src/%.md
	@emem -Rmo "$$(basename $< .md).html" $< src/footer.md

all:
	@sh build

clean:
	@rm -f *.html
	@rm -rf static
