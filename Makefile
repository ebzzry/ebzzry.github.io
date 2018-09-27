.PHONY: all clean rebuild

DOSIEROJ=$(wildcard fkd/*.md)
KONSTRUILO=emem

OG_TITOLO="$$(head -1 $<)"
OG_TIPO="article"
OG_BILDO="https://ebzzry.io/static/ico/android-chrome-512x512.png"
ANALITIKOJ="93746003-1"

%.html: fkd/%.md
	$(KONSTRUILO) --og-title $(OG_TITOLO) --og-type $(OG_TIPO) -D $(OG_TITOLO) -K "ebzzry, rommel, martinez, rommel martinez" --og-url "https://ebzzry.io/$$(basename $< .md).html" --og-image $(OG_BILDO) --analytics $(ANALITIKOJ) -RFiamuo "$$(basename $< .md).html" $<

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
