.PHONY: all clean rebuild

FILES=$(wildcard fkd/*.md)
BUILDER=emem

OG_TITLE="$$(head -1 $<)"
OG_TYPE="article"
OG_IMAGE="https://ebzzry.io/static/ico/android-chrome-512x512.png"
ANALYTICS="93746003-1"


%.html: fkd/%.md
	$(BUILDER) \
          --og-title $(OG_TITLE) --og-type $(OG_TYPE) \
          --og-url "https://ebzzry.io/$$(basename $< .md).html" \
          --og-image $(OG_IMAGE) \
          --analytics $(ANALYTICS) \
          -RFiamuo "$$(basename $< .md).html" \
          $<

all:
	$(BUILDER) -r
	$(MAKE) $(MFLAGS) -C eo
	$(MAKE) $(MFLAGS) -C en
	parallel --will-cite "$(MAKE) {/.}.html" ::: $(FILES)

clean:
	find . -maxdepth 1 -name '*.html' ! -name 'sitemap.html' ! -name 'index.html' -exec rm -vf {} \;
	rm -rvf static
	$(MAKE) -C eo $@
	$(MAKE) -C en $@

rebuild:
	$(MAKE) clean
	$(MAKE)
