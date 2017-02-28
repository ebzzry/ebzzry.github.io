.PHONY: all clean

FILES=$(filter-out src/footer.md, $(wildcard src/*.md))
BUILDER=emem

%.html: src/%.md
	$(BUILDER) -Rmo "$$(basename $< .md).html" $< src/footer.md

all:
	$(BUILDER) -r
	parallel --will-cite 'emem -Rmo {/.}.html {} src/footer.md' ::: $(FILES)

clean:
	rm -f *.html
	rm -rf static
