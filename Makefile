.PHONY: all clean

SRC_FILES = $(filter-out src/footer.md, $(wildcard src/*.md))

%.html: src/%.md
	emem -Rmo "$$(basename $< .md).html" $< src/footer.md

all:
	emem -r
	parallel --will-cite 'emem -Rmo {/.}.html {} src/footer.md' ::: $(SRC_FILES)

clean:
	rm -f *.html
	rm -rf static
