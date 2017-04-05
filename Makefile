all: docs

docs: docs/README.html docs/README.pdf

docs/README.html: README.adoc
	asciidoctor -D docs $<

docs/README.pdf: README.adoc
	asciidoctor-pdf -D docs $<
