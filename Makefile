
FILE=main

LATEX=lualatex
BIBTEX=bibtex

LATEX_OPTS=-interaction=nonstopmode -halt-on-error -synctex=1

all: document

dist:
	./helpers/dist.sh

ebooks:
	$(shell org-tangle ./recitations.md.org)
	./helpers/generate_ebooks.sh

four-times:
	./helpers/four-times.sh

document:
	$(shell org-tangle ./recitations.tex.org)
	$(LATEX) $(LATEX_OPTS) $(FILE).tex;

sass:
	node-sass ./assets/sass -o ./assets/stylesheets

sass-watch:
	node-sass -w ./assets/sass -o ./assets/stylesheets

preview:
	latexmk -pvc $(FILE).tex
