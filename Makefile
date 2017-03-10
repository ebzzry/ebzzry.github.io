.PHONY: all clean

FILES=$(filter-out src/footer.md, $(wildcard src/*.md))
BUILDER=emem

%.html: src/%.md
	$(BUILDER) -FRiamo "$$(basename $< .md).html" $< src/footer.md

all:
	$(BUILDER) -r
	parallel --will-cite "$(BUILDER) -FRiamo {/.}.html {} src/footer.md" ::: $(FILES)

upload:
	git push origin master

force-upload:
	git push --force origin master

clean:
	rm -f *.html
	rm -rf static
