FILE_HANDBOOK=main_handbook
FILE_REFERENCE=main_reference

LATEX=lualatex
BIBTEX=bibtex

LATEX_OPTS=-interaction=nonstopmode -halt-on-error -synctex=1

all:
	@echo "Specify the make target, such as 'handbook' or 'reference'."

dist:
	./helpers/dist.sh

ebooks:
	./helpers/generate_ebooks.sh

handbook-four-times:
	./helpers/four-times.sh handbook

reference-four-times:
	./helpers/four-times.sh reference

handbook:
	cat $(FILE_HANDBOOK).fir | \
		sed '/\\contentsfinish/d' | \
		sort > $(FILE_HANDBOOK).fir.tmp
	echo '\\contentsfinish' >> $(FILE_HANDBOOK).fir.tmp
	mv $(FILE_HANDBOOK).fir.tmp $(FILE_HANDBOOK).fir
	$(LATEX) $(LATEX_OPTS) $(FILE_HANDBOOK).tex;

reference:
	cat $(FILE_REFERENCE).fir | \
		sed '/\\contentsfinish/d' | \
		sort > $(FILE_REFERENCE).fir.tmp
	echo '\\contentsfinish' >> $(FILE_REFERENCE).fir.tmp
	mv $(FILE_REFERENCE).fir.tmp $(FILE_REFERENCE).fir
	$(LATEX) $(LATEX_OPTS) $(FILE_REFERENCE).tex;

sass:
	node-sass ./assets/sass -o ./assets/stylesheets

sass-watch:
	node-sass -w ./assets/sass -o ./assets/stylesheets

preview-handbook:
	latexmk -pvc $(FILE_HANDBOOK).tex

