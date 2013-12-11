ANOLIS = anolis

all: index.html data/xrefs/dom/serviceworker.json

data/xrefs/dom/serviceworker.json: index.src.html Makefile
	$(ANOLIS) --dump-xrefs=$@ $< /tmp/spec

index.html: index.src.html data Makefile
	$(ANOLIS) --omit-optional-tags --quote-attr-values --xref="data" \
	--w3c-compat --enable=xspecxref --enable=refs \
	--w3c-shortname="serviceworker" \
	--filter=".publish, title + style" $< $@

publish: index.src.html data Makefile
	$(ANOLIS) --omit-optional-tags --quote-attr-values --xref="data" \
	--w3c-compat --enable=xspecxref --enable=refs \
	--w3c-shortname="serviceworker" \
	--filter=".dontpublish, .w3conly, title + style" \
	--pubdate="$(PUBDATE)" --w3c-status=WD $< TR/index.html
