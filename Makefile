.PHONY: all clean rebuild

FILES=$(wildcard src/*.md)
BUILDER=emem

DESCRIPTION="$$(cat DESCRIPTION)"
KEYWORDS="$$(cat KEYWORDS)"
OG_TITLE="$$(head -1 $<)"
OG_TYPE="article"
OG_IMAGE="https://ebzzry.io/static/ico/android-chrome-512x512.png"
ANALYTICS="93746003-1"


%.html: src/%.md
	$(BUILDER) -D $(DESCRIPTION) -K $(KEYWORDS) \
          --og-title $(OG_TITLE) --og-type $(OG_TYPE) \
          --og-url "https://ebzzry.io/$$(basename $< .md).html" \
          --og-image $(OG_IMAGE) \
          --analytics $(ANALYTICS) \
          -RFiamuo "$$(basename $< .md).html" \
          $< en/src/footer.md

all:
	$(BUILDER) -r
	$(MAKE) $(MFLAGS) -C en
	$(MAKE) $(MFLAGS) -C eo
	parallel --will-cite "$(MAKE) {/.}.html" ::: $(FILES)

clean:
	find . -maxdepth 1 -name '*.html' ! -name 'sitemap.html' ! -name 'index.html' -exec rm -vf {} \;
	rm -rvf static
	$(MAKE) -C en $@
	$(MAKE) -C eo $@

rebuild:
	$(MAKE) clean
	$(MAKE)
