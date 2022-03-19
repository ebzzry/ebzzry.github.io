.PHONY: all clean rebuild

KONSTRUILO=emem

all:
	$(KONSTRUILO) -r
	$(MAKE) $(MFLAGS) -C fkd/r
	$(MAKE) $(MFLAGS) -C fkd/eo
	$(MAKE) $(MFLAGS) -C fkd/en

clean:
	find . -maxdepth 1 -name '*.html' ! -name 'sitemap.html' ! -name 'index.html' ! -name 'dat' -exec rm -vf {} \;
	rm -rvf static
	$(MAKE) -C fkd/r $@
	$(MAKE) -C fkd/eo $@
	$(MAKE) -C fkd/en $@

rebuild:
	$(MAKE) clean
	$(MAKE)
