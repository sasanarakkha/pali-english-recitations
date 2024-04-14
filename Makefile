# LuaLaTeX pdf
FILE=main
LATEX=lualatex
BIBTEX=bibtex
LATEX_OPTS=-interaction=nonstopmode -halt-on-error -synctex=1
TEXMFHOME=~/.texmf

# https://www.ctan.org/pkg/tabularray
TABULARRAY_URL = https://mirrors.ctan.org/macros/latex/contrib/tabularray.zip
# https://www.ctan.org/pkg/ninecolors
NINECOLORS_URL = https://mirrors.ctan.org/macros/latex/contrib/ninecolors.zip


#-----------------------------------------------------------------------------------------#


# EPUB varaibles derived from https://github.com/daniel-j/epubmake
BUILDDIR      := ./build/
RELEASENAME   := SBS_Pāli-English_Recitations
CURRENTEPUB   := ./epub/current-recitations.epub
HTMLSOURCE    := ./epub/
EXTRACTSOURCE := ./
PDFFILE       := $(BUILDDIR)/$(RELEASENAME).pdf
EPUBFILE      := $(BUILDDIR)/$(RELEASENAME).epub
KINDLEFILE    := $(BUILDDIR)/$(RELEASENAME).mobi
AZW3FILE      := $(BUILDDIR)/$(RELEASENAME).azw3
HANDBOOK_PDF  := $(BUILDDIR)/$(RELEASENAME)_Handbook.pdf


ifneq (, $(shell which epubcheck))
EPUBCHECK := epubcheck
endif

ORG_TANGLE := ./assets/scripts/org-tangle.py


EBOOKEDITOR  := $(shell command -v sigil  2>&1 || sigil 2>&1)
EBOOKPOLISH  := $(shell command -v ebook-polish 2>&1)
EBOOKVIEWER  := $(shell command -v ebook-viewer 2>&1)
EBOOKCONVERT := $(shell command -v ebook-convert 2>&1)
JAVA         := $(shell command -v java 2>&1)
INOTIFYWAIT  := $(shell command -v inotifywait 2>&1)


# EPUBCHECK_VERSION = 4.2.6
# https://github.com/IDPF/epubcheck/releases
# EPUBCHECK_URL = https://github.com/IDPF/epubcheck/releases/download/v$(EPUBCHECK_VERSION)/epubcheck-$(EPUBCHECK_VERSION).zip


HTMLSOURCEFILES := $(shell find $(HTMLSOURCE) 2> /dev/null | sort)
XHTMLFILES      := $(shell find $(HTMLSOURCE) -name '*.xhtml' 2> /dev/null | sort)

TODAY := $(shell date --iso-8601)


#-----------------------------------------------------------------------------------------#

# Usual phonies
.PHONY: all test clean validate optimize view editepub watchepub
# Targets with complex dependencies
.PHONY: $(PDFFILE) $(HANDBOOK_PDF)
# Alt names
.PHONY: pdf pdf2x handbook

all: pdf2x $(HANDBOOK_PDF) $(EPUBFILE) $(KINDLEFILE) $(AZW3FILE)


#-----------------------------------------------------------------------------------------#


$(BUILDDIR):
	@echo "Creating a build directory..."
	@mkdir -p "$(BUILDDIR)"


#-----------------------------------------------------------------------------------------#


pdf: $(PDFFILE)
$(PDFFILE): $(BUILDDIR)
	@echo "Tangling org document..."
	$(ORG_TANGLE) ./recitations.tex.org
	$(LATEX) $(LATEX_OPTS) $(FILE).tex;
	mv -f $(FILE).pdf "$(PDFFILE)"


#-----------------------------------------------------------------------------------------#


pdf2x: $(BUILDDIR)
	@echo "Tangling org document..."
	@$(ORG_TANGLE) ./recitations.tex.org
	$(LATEX) $(LATEX_OPTS) $(FILE).tex;
	@echo "Second run..."
	$(LATEX) $(LATEX_OPTS) $(FILE).tex;
	mv -f $(FILE).pdf "$(PDFFILE)"


#-----------------------------------------------------------------------------------------#


handbook: $(HANDBOOK_PDF)
$(HANDBOOK_PDF): $(BUILDDIR)
	@echo "Tangling org document..."
	@$(ORG_TANGLE) ./recitations.tex.org
	$(LATEX) $(LATEX_OPTS) $(FILE).tex;
	mv -f $(FILE).pdf "$(HANDBOOK_PDF)"


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

COPYRIGHT_FILE := epub/html/OEBPS/Text/copyright.xhtml
COPYRIGHT_SENTINEL := $(BUILDDIR)copyright_$(TODAY).xhtml


$(COPYRIGHT_SENTINEL): $(COPYRIGHT_FILE).tpl
	sed 's/\(This version was created on:\) *[0-9-]\{10\}/\1 '"$(TODAY)"'/' $< \
		> $(COPYRIGHT_SENTINEL)


epub: $(EPUBFILE)
$(EPUBFILE): $(BUILDDIR) $(HTMLSOURCEFILES) $(COPYRIGHT_SENTINEL)
	@echo "Building EPUB ebook..."
	cp $(COPYRIGHT_SENTINEL) $(COPYRIGHT_FILE)
	rm -f "$(EPUBFILE)"
	cd "$(HTMLSOURCE)" && \
		zip --exclude '*.epub' --exclude '*.tpl' -Xr9D "../$(EPUBFILE)" mimetype .


#-----------------------------------------------------------------------------------------#


# Uses Calibre to produce a mobi Kindle ebook
mobi: $(KINDLEFILE)
$(KINDLEFILE): EPUB_COPY := $(basename $(EPUBFILE))_copy.epub
$(KINDLEFILE): $(BUILDDIR) $(EPUBFILE)
	@echo "Building mobi with KindleGen..."
	cp -f "$(EPUBFILE)" "$(EPUB_COPY)"
# FIXME Is following block it in use enywhere?
ifdef PNGFILES
	@for current in $(PNGFILES); do \
		channels=$$(identify -format '%[channels]' "$$current"); \
		if [[ "$$channels" == "graya" ]]; then \
			mkdir -p "$$(dirname "tmp/$$current")"; \
			echo "Converting $$current to RGB..."; \
			convert "$$current" -colorspace rgb "tmp/$$current"; \
		fi; \
	done
	@cd "tmp/$(HTMLSOURCE)" && zip -Xr9D "../../$(EPUB_COPY)" .
	@rm -rf "tmp/"
endif
	# --mobi-keep-original-images keeps transparent BG, but makes MOBI larger
	ebook-convert "$(EPUB_COPY)" "$(KINDLEFILE)" \
		--mobi-file-type=new --pretty-print --no-inline-toc --disable-font-rescaling \
		--embed-all-fonts --subset-embedded-fonts \
		--mobi-keep-original-images
	rm -f "$(EPUB_COPY)"


#-----------------------------------------------------------------------------------------#


# Use Calibre to generate an azw3 Kindle ebook
azw3: $(AZW3FILE)
$(AZW3FILE): $(BUILDDIR) $(EPUBFILE)
ifndef EBOOKCONVERT
	@echo "Error: Calibre was not found. Unable to convert to Kindle AZW3."
	@exit 1
else
	@echo "Building Kindle AZW3 ebook with Calibre..."
	ebook-convert "$(EPUBFILE)" "$(AZW3FILE)" --pretty-print --no-inline-toc --max-toc-links=0 --disable-font-rescaling
endif


#-----------------------------------------------------------------------------------------#


# FIXME Delete or move up and update to set $(EPUBCHECK)
$(EPUBCHECK):
	@echo Downloading epubcheck...
	@curl -o "epubcheck.zip" -L "$(EPUBCHECK_URL)" --connect-timeout 30
	@mkdir -p `dirname $(EPUBCHECK)`
	@unzip -q "epubcheck.zip"
	@rm -rf `dirname $(EPUBCHECK)`
	@mv "epubcheck-$(EPUBCHECK_VERSION)" "`dirname $(EPUBCHECK)`"
	@rm epubcheck.zip


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


view: $(CURRENTEPUB)
ifndef EBOOKVIEWER
	@echo "Error: Calibre was not found. Unable to open ebook viewer."
	@exit 1
else
	@ebook-viewer --detach "$(CURRENTEPUB)"
endif


#-----------------------------------------------------------------------------------------#


editepub: $(CURRENTEPUB)
ifndef EBOOKEDITOR
	@echo "Error: Sigil was not found. Installing with Flatpak."
	# @flatpak install com.sigil_ebook.Sigil -y
	# @ln -s /var/lib/flatpak/exports/bin/com.sigil_ebook.Sigil ~/.local/bin/sigil
	@exit 1
else
	@ sigil "$(CURRENTEPUB)" || sigil "$(CURRENTEPUB)"
endif

clean:
	@echo Removing artifacts...
	rm -f \
		"$(PDFFILE)" "$(EPUBFILE)" "$(KINDLEFILE)" "$(AZW3FILE)" \
		"$(IBOOKSFILE)" "$(HANDBOOK_PDF)" "$(COPYRIGHT_SENTINEL)
	@# only remove dir if it's empty:
	@(rm -fd $(BUILDDIR) || true)


#-----------------------------------------------------------------------------------------#

editwatchepub: $(CURRENTEPUB)
	@echo "Opening current-recitations.epub in Sigil for editing..."
	@echo "Watching file for errors..."
	@make -j edit watchcurrent



#-----------------------------------------------------------------------------------------#


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


#-----------------------------------------------------------------------------------------#


release: $(EPUBFILE) $(KINDLEFILE) $(AZW3FILE)
	@mkdir -pv release
	cp "$(EPUBFILE)" "release/$$(date +$(RELEASENAME)).epub"
	cp "$(KINDLEFILE)" "release/$$(date +$(RELEASENAME)).mobi"
	cp "$(AZW3FILE)" "release/$$(date +$(RELEASENAME)).azw3"
