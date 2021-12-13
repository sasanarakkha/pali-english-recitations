FILE=main

LATEX=lualatex
BIBTEX=bibtex

LATEX_OPTS=-interaction=nonstopmode -halt-on-error -synctex=1

all: document


dist:
	./helpers/dist.sh

ebooks:
	./helpers/generate_ebooks.sh

four-times:
	./helpers/four-times.sh

document:
	cat $(FILE).fir | \
		sed '/\\contentsfinish/d' | \
		sort > $(FILE).fir.tmp
	echo '\\contentsfinish' >> $(FILE).fir.tmp
	mv $(FILE).fir.tmp $(FILE).fir
	$(LATEX) $(LATEX_OPTS) $(FILE).tex;

sass:
	node-sass ./assets/sass -o ./assets/stylesheets

sass-watch:
	node-sass -w ./assets/sass -o ./assets/stylesheets

preview:
	latexmk -pvc $(FILE).tex
