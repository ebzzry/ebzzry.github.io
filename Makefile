.PHONY: all

FILES=$(wildcard src/*.md)
BUILDER=emem

DESCRIPTION="$$(cat DESCRIPTION)"
KEYWORDS="$$(cat KEYWORDS)"
OG_TITLE="$$(head -1 $<)"
OG_TYPE="article"
OG_IMAGE="http://ebzzry.io/static/ico/android-chrome-512x512.png"
ANALYTICS="93746003-1"


%.html: src/%.md
	$(BUILDER) -D $(DESCRIPTION) -K $(KEYWORDS) \
          --og-title $(OG_TITLE) --og-type $(OG_TYPE) \
          --og-url "http://ebzzry.io/$$(basename $< .md).html" \
          --og-image $(OG_IMAGE) \
          --analytics $(ANALYTICS) \
          -RFiauo "$$(basename $< .md).html" \
          $<

all:
	$(BUILDER) -r
	$(MAKE) $(MFLAGS) -C en
	time parallel --will-cite "$(MAKE) {/.}.html" ::: $(FILES)
