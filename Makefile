# LuaLaTeX pdf
FILE := main
# A6_FILE := A6-main
# A4_FILE := A4-main
LATEX_OPTS := -interaction=nonstopmode -halt-on-error -synctex=1
LATEX := latexmk -pdflualatex='lualatex $(LATEX_OPTS)'
TEXMFHOME := ~/.texmf

# https://www.ctan.org/pkg/tabularray
TABULARRAY_URL = https://mirrors.ctan.org/macros/latex/contrib/tabularray.zip
# https://www.ctan.org/pkg/ninecolors
NINECOLORS_URL = https://mirrors.ctan.org/macros/latex/contrib/ninecolors.zip


#-----------------------------------------------------------------------------------------#


BUILDDIR      := ./build/
RELEASENAME   := SBS_Pāli-English_Recitations
# FIXME Create target or decide to delete view, editepub etc
CURRENTEPUB   := ./epub/current-recitations.epub
HTMLSOURCE    := ./epub/
EXTRACTSOURCE := ./
PDFFILE       := $(BUILDDIR)/$(RELEASENAME).pdf
PDFFILE_A6    := $(BUILDDIR)/$(RELEASENAME)-A6.pdf
PDFFILE_B6    := $(BUILDDIR)/$(RELEASENAME)-B6.pdf
EPUBFILE      := $(BUILDDIR)/$(RELEASENAME).epub
KINDLEFILE    := $(BUILDDIR)/$(RELEASENAME).mobi
AZW3FILE      := $(BUILDDIR)/$(RELEASENAME).azw3


ifneq (, $(shell which epubcheck))
EPUBCHECK := epubcheck
endif

ORG_TANGLE := ./assets/bin/org-tangle.py


EBOOKEDITOR  := $(shell command -v sigil  2>&1 || sigil 2>&1)
EBOOKPOLISH  := $(shell command -v ebook-polish 2>&1)
EBOOKVIEWER  := $(shell command -v ebook-viewer 2>&1)
EBOOKCONVERT := $(shell command -v ebook-convert 2>&1)
JAVA         := $(shell command -v java 2>&1)
INOTIFYWAIT  := $(shell command -v inotifywait 2>&1)

LATEX_AUX := \
	$(BUILDDIR)/*.aux $(BUILDDIR)/*.ent $(BUILDDIR)/*.fls $(BUILDDIR)/*.toc \
	$(BUILDDIR)/*.upa $(BUILDDIR)/*.log $(BUILDDIR)/*latexmk $(BUILDDIR)/*.synctex.gz
MKBUILDDIR := @mkdir -p $(BUILDDIR)


TODAY := $(shell date --iso-8601)
COPYRIGHT_FILE := epub/html/OEBPS/Text/copyright.xhtml
COPYRIGHT_SENTINEL := $(BUILDDIR)copyright_$(TODAY).xhtml

HTMLSOURCEFILES := $(shell find $(HTMLSOURCE) ! -name '*.tpl' -type f)
XHTMLFILES      := $(shell find $(HTMLSOURCE) -name '*.xhtml' 2> /dev/null | sort)


#-----------------------------------------------------------------------------------------#

# Usual phonies
.PHONY: all test clean
# Targets with complex dependencies
.PHONY: $(PDFFILE) TANGLED
# Aliases
.PHONY: pdf pdf2x epub mobi
# Commands
.PHONY: checkepub validate optimize view editepub watchepub

all: $(PDFFILE) $(PDFFILE_A6) $(PDFFILE_B6) $(EPUBFILE) $(KINDLEFILE) $(AZW3FILE)
all-pdf: $(PDFFILE) $(PDFFILE_A6) $(PDFFILE_B6)


#-----------------------------------------------------------------------------------------#


TANGLED: ./recitations.tex.org
	$(ORG_TANGLE) $<

pdf2x: $(PDFFILE)  # Legacy target for compliance
pdf: $(PDFFILE)
$(PDFFILE): TANGLED
	$(MKBUILDDIR)
	$(LATEX) --jobname=$(basename $@) $(FILE)_a5digital.tex

pdf-a6: $(PDFFILE_A6)
$(PDFFILE_A6): TANGLED
	$(MKBUILDDIR)
	$(LATEX) -jobname=$(basename $@) $(FILE)_a6.tex

pdf-b6: $(PDFFILE_B6)
$(PDFFILE_B6): TANGLED
	$(MKBUILDDIR)
	$(LATEX) -jobname=$(basename $@) $(FILE)_b6.tex


#-----------------------------------------------------------------------------------------#


pdfrequirements:
	@echo "Downloading LaTeX requirements..."
	@mkdir -pv $(TEXMFHOME)/tex
	@echo "Downloading Tabularray..."
	@curl -o "tabularray.zip" -L "$(TABULARRAY_URL)" --connect-timeout 30
	@echo "Downloading Ninecolors..."
	@curl -o "ninecolors.zip" -L "$(NINECOLORS_URL)" --connect-timeout 30
	@unzip -oq "tabularray.zip"
	@unzip -oq "ninecolors.zip"
	@mv "tabularray" "ninecolors" $(TEXMFHOME)/tex
	@rm -rf "tabularray.zip" "ninecolors.zip"
	@echo "Completed."


#-----------------------------------------------------------------------------------------#



$(COPYRIGHT_SENTINEL): $(COPYRIGHT_FILE).tpl
	$(MKBUILDDIR)
	sed 's/\(This version was created on:\) *[0-9-]\{10\}/\1 '"$(TODAY)"'/' $< \
		> $(COPYRIGHT_SENTINEL)


epub: $(EPUBFILE)
$(EPUBFILE): $(HTMLSOURCEFILES) $(COPYRIGHT_SENTINEL)
	$(MKBUILDDIR)
	@echo "Building EPUB ebook..."
	cp $(COPYRIGHT_SENTINEL) $(COPYRIGHT_FILE)
	rm -f "$(EPUBFILE)"
	cd "$(HTMLSOURCE)" && \
		zip --exclude '*.epub' --exclude '*.tpl' -Xr9D "../$(EPUBFILE)" mimetype .


#-----------------------------------------------------------------------------------------#


# Uses Calibre to produce a mobi Kindle ebook
mobi: $(KINDLEFILE)
$(KINDLEFILE): EPUB_COPY := $(basename $(EPUBFILE))_copy.epub
$(KINDLEFILE): $(EPUBFILE)
	$(MKBUILDDIR)
	@echo "Building mobi with KindleGen..."
	cp -f "$(EPUBFILE)" "$(EPUB_COPY)"
	ebook-convert "$(EPUB_COPY)" "$(KINDLEFILE)" \
		--mobi-file-type=new --pretty-print --no-inline-toc --disable-font-rescaling \
		--embed-all-fonts --subset-embedded-fonts \
		--mobi-keep-original-images
	rm -f "$(EPUB_COPY)"


#-----------------------------------------------------------------------------------------#


# Use Calibre to generate an azw3 Kindle ebook
azw3: $(AZW3FILE)
$(AZW3FILE): $(EPUBFILE)
	$(MKBUILDDIR)
ifndef EBOOKCONVERT
	@echo "Error: Calibre was not found. Unable to convert to Kindle AZW3."
	@exit 1
else
	@echo "Building Kindle AZW3 ebook with Calibre..."
	ebook-convert "$(EPUBFILE)" "$(AZW3FILE)" --pretty-print --no-inline-toc --max-toc-links=0 --disable-font-rescaling
endif


#-----------------------------------------------------------------------------------------#

checkepub: validate  # FIXME Redundant target
validate: $(EPUBFILE)
ifdef EPUBCHECK
	@echo "Validating EPUB..."
	"$(EPUBCHECK)" "$(EPUBFILE)"
else
	$(error Missing epubcheck)
endif

#-----------------------------------------------------------------------------------------#


optimize: $(EPUBFILE)
ifndef EBOOKPOLISH
	@echo "Error: Calibre was not found. Unable to optimize."
	@exit 1
else
	@echo "Compressing images. This may take a while..."
	@ebook-polish --verbose --compress-images "$(EPUBFILE)" "$(EPUBFILE)"
endif


#-----------------------------------------------------------------------------------------#

# TODO needs a rework or consider doing manually
# editepub: $(CURRENTEPUB)
# ifndef EBOOKEDITOR
# 	@echo "Error: Sigil was not found. Installing with Flatpak."
# 	@exit 1
# else
	# @ sigil "$(CURRENTEPUB)" || sigil "$(CURRENTEPUB)"
# endif


#-----------------------------------------------------------------------------------------#


clean:
	@echo Removing artifacts...
	rm -f \
		"$(PDFFILE)" "$(PDFFILE_A6)" "$(PDFFILE_B6)" "$(EPUBFILE)" "$(KINDLEFILE)" \
	"$(AZW3FILE)" "$(IBOOKSFILE)" "$(COPYRIGHT_SENTINEL)" $(LATEX_AUX)
	# only remove dir if it's empty:
	(rm -fd $(BUILDDIR) || true)


#-----------------------------------------------------------------------------------------#


editwatchepub: $(CURRENTEPUB)
	@echo "Opening current-recitations.epub in Sigil for editing..."
	@echo "Watching file for errors..."
	@make -j edit watchcurrent


#-----------------------------------------------------------------------------------------#

# TODO need command to zip up epub
extractepub: $(CURRENTEPUB)
	@echo "Extracting $(CURRENTEPUB) into $(HTMLSOURCE)"
	@mkdir -p "$(HTMLSOURCE)"
	@unzip -o "$(CURRENTEPUB)" -d "$(HTMLSOURCE)"
	@echo "Extracting HTML hierarchy from EPUB for version control..."


#-----------------------------------------------------------------------------------------#


watchepub: $(CURRENTEPUB) $(EPUBCHECK)
ifndef JAVA
	$(error Java was not found. Unable to validate ebook)
endif
ifndef INOTIFYWAIT
	$(error inotifywait was not found. Unable to watch ebook for changes)
endif
	@echo "Watching $(CURRENTEPUB)"
	@while true; do \
		$(INOTIFYWAIT) -qe close_write "$(CURRENTEPUB)"; \
		echo "Validating $(CURRENTEPUB)..."; \
		$(JAVA) -jar "$(EPUBCHECK)" "$(CURRENTEPUB)"; \
	done
