.PHONY: all clean rebuild

EMEM=emem

all:
	$(EMEM) -r
	$(MAKE) $(MFLAGS) -C src/r
	$(MAKE) $(MFLAGS) -C src/eo
	$(MAKE) $(MFLAGS) -C src/en

clean:
	find . -maxdepth 1 -name '*.html' ! -name 'sitemap.html' ! -name 'index.html' ! -name 'dat' -exec rm -vf {} \;
	rm -rvf static
	$(MAKE) -C src/r $@
	$(MAKE) -C src/eo $@
	$(MAKE) -C src/en $@

rebuild:
	$(MAKE) clean
	$(MAKE)
