.PHONY: all clean rebuild

DOSIEROJ=$(wildcard fkd/*.md)
KONSTRUILO=emem

OG_TITLE="$$(head -1 $<)"
OG_TYPE="article"
OG_IMAGE="https://ebzzry.io/static/ico/android-chrome-512x512.png"
ANALITIKOJ="93746003-1"

%.html: fkd/%.md
	$(KONSTRUILO) \
          --og-title $(OG_TITLE) --og-type $(OG_TYPE) \
          -D $(OG_TITLE) \
          -K "ebzzry, rommel, martinez, rommel martinez" \
          --og-url "https://ebzzry.io/$$(basename $< .md).html" \
          --og-image $(OG_IMAGE) \
          --analytics $(ANALITIKOJ) \
          -RFiamuo "$$(basename $< .md).html" \
          $<

all:
	$(KONSTRUILO) -r
	$(MAKE) $(MFLAGS) -C eo
	$(MAKE) $(MFLAGS) -C en
	parallel --will-cite "$(MAKE) {/.}.html" ::: $(DOSIEROJ)

clean:
	find . -maxdepth 1 -name '*.html' ! -name 'sitemap.html' ! -name 'index.html' -exec rm -vf {} \;
	rm -rvf static
	$(MAKE) -C eo $@
	$(MAKE) -C en $@

rebuild:
	$(MAKE) clean
	$(MAKE)
