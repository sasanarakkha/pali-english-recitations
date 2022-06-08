# LuaLaTeX pdf
FILE=main
LATEX=lualatex
BIBTEX=bibtex
LATEX_OPTS=-interaction=nonstopmode -halt-on-error -synctex=1


# https://www.ctan.org/pkg/tabularray
TABULARRAY_URL = https://mirrors.ctan.org/macros/latex/contrib/tabularray.zip
# https://www.ctan.org/pkg/ninecolors
NINECOLORS_URL = https://mirrors.ctan.org/macros/latex/contrib/ninecolors.zip


#-----------------------------------------------------------------------------------------#


# EPUB varaibles derived from https://github.com/daniel-j/epubmake
RELEASENAME   := "SBS Pāli-English Recitations"
CURRENTEPUB   := ./manuscript/current-recitations.epub
SOURCE        := ./manuscript/
EXTRACTSOURCE := ./
EPUBFILE      := ./build/SBS\ Pāli-English\ Recitations.epub
KINDLEFILE    := ./build/SBS\ Pāli-English\ Recitations.mobi
AZW3FILE      := ./build/SBS\ Pāli-English\ Recitations.azw3


EPUBCHECK := ./assets/tools/epubcheck/epubcheck.jar
KINDLEGEN := ./assets/tools/kindlegen


EBOOKEDITOR  := $(shell command -v sigil  2>&1 || nixGL sigil 2>&1)
EBOOKPOLISH  := $(shell command -v ebook-polish 2>&1)
EBOOKVIEWER  := $(shell command -v ebook-viewer 2>&1)
EBOOKCONVERT := $(shell command -v ebook-convert 2>&1)
JAVA         := $(shell command -v java 2>&1)
INOTIFYWAIT  := $(shell command -v inotifywait 2>&1)
MAKECURRENT  := $(shell command -v cd ./manuscript && zip -r html.zip html && mv html.zip current-recitations.epub)


EPUBCHECK_VERSION = 4.2.6
# https://github.com/IDPF/epubcheck/releases
EPUBCHECK_URL = https://github.com/IDPF/epubcheck/releases/download/v$(EPUBCHECK_VERSION)/epubcheck-$(EPUBCHECK_VERSION).zip
# http://www.amazon.com/gp/feature.html?docId=1000765211 -- KINDLEGEN IS NO LONGER ABLE TO BE DOWNLOADED
# KINDLEGEN_URL = http://kindlegen.s3.amazonaws.com/kindlegen_linux_2.6_i386_v2_9.tar.gz


SOURCEFILES := $(shell find $(SOURCE) 2> /dev/null | sort)
XHTMLFILES  := $(shell find $(SOURCE) -name '*.xhtml' 2> /dev/null | sort)


#-----------------------------------------------------------------------------------------#


all: document


#-----------------------------------------------------------------------------------------#


dist:
	./assets/tools/dist


#-----------------------------------------------------------------------------------------#


pdf:
	@echo "Tangling org document..."
	@org-tangle ./recitations.tex.org
	$(LATEX) $(LATEX_OPTS) $(FILE).tex;
	@mkdir -p ./build
	mv -f $(FILE).pdf "./build/SBS Pāli-English Recitations.pdf"


#-----------------------------------------------------------------------------------------#


pdf2x:
	@echo "Tangling org document..."
	@org-tangle ./recitations.tex.org
	$(LATEX) $(LATEX_OPTS) $(FILE).tex;
	@echo "Second run..."
	$(LATEX) $(LATEX_OPTS) $(FILE).tex;
	@mkdir -p ./build
	mv -f $(FILE).pdf "./build/SBS Pāli-English Recitations.pdf"


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


epub: $(EPUBFILE)
$(EPUBFILE): $(SOURCEFILES)
	@echo "Building EPUB ebook..."
	@mkdir -p `dirname $(EPUBFILE)`
	@rm -f "$(EPUBFILE)"
	@cd "$(SOURCE)" && zip -Xr9D "../$(EPUBFILE)" mimetype .


#-----------------------------------------------------------------------------------------#


# Uses Amazon's KindleGen to produce a mobi Kindle ebook
mobi: $(KINDLEFILE)
$(KINDLEFILE): $(EPUBFILE) $(KINDLEGEN)
	@echo "Building mobi with KindleGen..."
	@cp -f "$(EPUBFILE)" "$(KINDLEFILE).epub"
ifdef PNGFILES
	@for current in $(PNGFILES); do \
		channels=$$(identify -format '%[channels]' "$$current"); \
		if [[ "$$channels" == "graya" ]]; then \
			mkdir -p "$$(dirname "tmp/$$current")"; \
			echo "Converting $$current to RGB..."; \
			convert "$$current" -colorspace rgb "tmp/$$current"; \
		fi; \
	done
	@cd "tmp/$(SOURCE)" && zip -Xr9D "../../$(KINDLEFILE).epub" .
	@rm -rf "tmp/"
endif
	@$(KINDLEGEN) "$(KINDLEFILE).epub" -dont_append_source -c1 || exit 0 # -c1 means standard PalmDOC compression. -c2 takes too long but probably makes it even smaller.
	@rm -f "$(KINDLEFILE).epub"
	@mv "$(KINDLEFILE).mobi" "$(KINDLEFILE)"


#-----------------------------------------------------------------------------------------#


# Use Calibre to generate an azw3 Kindle ebook
azw3: $(AZW3FILE)
$(AZW3FILE): $(EPUBFILE)
ifndef EBOOKCONVERT
	@echo "Error: Calibre was not found. Unable to convert to Kindle AZW3."
	@exit 1
else
	@echo "Building Kindle AZW3 ebook with Calibre..."
	ebook-convert "$(EPUBFILE)" "$(AZW3FILE)" --pretty-print --no-inline-toc --max-toc-links=0 --disable-font-rescaling
endif

$(EPUBCHECK):
	@echo Downloading epubcheck...
	@curl -o "epubcheck.zip" -L "$(EPUBCHECK_URL)" --connect-timeout 30
	@mkdir -p `dirname $(EPUBCHECK)`
	@unzip -q "epubcheck.zip"
	@rm -rf `dirname $(EPUBCHECK)`
	@mv "epubcheck-$(EPUBCHECK_VERSION)" "`dirname $(EPUBCHECK)`"
	@rm epubcheck.zip

# Kindlegen can no longer downloaded directly from Amazon
# $(KINDLEGEN):
# 	@echo Downloading kindlegen...
# 	@curl -o "kindlegen.tar.gz" -L "$(KINDLEGEN_URL)" --connect-timeout 30
# 	@mkdir -p `dirname $(KINDLEGEN)`
# 	@tar -zxf "kindlegen.tar.gz" -C `dirname $(KINDLEGEN)`
# 	@rm "kindlegen.tar.gz"


#-----------------------------------------------------------------------------------------#


validate: $(EPUBFILE) $(EPUBCHECK)
ifndef JAVA
	@echo "Warning: Java was not found. Unable to validate ebook."
else
	@echo "Validating EPUB..."
	@$(JAVA) -jar "$(EPUBCHECK)" "$(EPUBFILE)"
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


edit: $(CURRENTEPUB)
ifndef EBOOKEDITOR
	@echo "Error: Sigil was not found. Unable to edit ebook."
	@exit 1
else
	@ nixGL sigil "$(CURRENTEPUB)" || sigil "$(CURRENTEPUB)"
endif

clean:
	@echo Removing built EPUB/KEPUB/Kindle files...
	rm -f "$(EPUBFILE)"
	rm -f "$(KEPUBFILE)"
	rm -f "$(KINDLEFILE)"
	rm -f "$(AZW3FILE)"
	rm -f "$(IBOOKSFILE)"
	rm -f "./build/SBS Pāli-English Recitations.pdf"
	@# only remove dir if it's empty:
	@(rmdir `dirname $(EPUBFILE)`; exit 0)


#-----------------------------------------------------------------------------------------#

editwatchcurrent: $(CURRENTEPUB)
	@echo "Opening current-recitations.epub in Sigil for editing..."
	@echo "Watching file for errors..."
	@make -j edit watchcurrent

#-----------------------------------------------------------------------------------------#


checkcurrent: $(CURRENTEPUB)
	@clear 
	@epubcheck manuscript/current-recitations.epub


#-----------------------------------------------------------------------------------------#


current:
	@echo "Archiving html and renaming to epub..."
	@cd ./manuscript && zip -r html.zip html && mv html.zip current-recitations.epub
	@echo "EPUB made and ready for editing..."


#-----------------------------------------------------------------------------------------#


extractcurrent: $(CURRENTEPUB)
	@echo "Extracting $(CURRENTEPUB) into $(SOURCE)"
	@mkdir -p "$(SOURCE)"
	@unzip -o "$(CURRENTEPUB)" -d "$(SOURCE)"
	@rm -rf ./manuscript/META-INF ./manuscript/mimetype


#-----------------------------------------------------------------------------------------#


watchcurrent: $(CURRENTEPUB) $(EPUBCHECK)
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


release: $(EPUBFILE) $(KINDLEFILE) $(KEPUBFILE) $(AZW3FILE)
	@mkdir -pv release
	cp "$(EPUBFILE)" "release/$$(date +$(RELEASENAME)).epub"
	cp "$(KEPUBFILE)" "release/$$(date +$(RELEASENAME)).kepub.epub"
	cp "$(KINDLEFILE)" "release/$$(date +$(RELEASENAME)).mobi"
	cp "$(AZW3FILE)" "release/$$(date +$(RELEASENAME)).azw3"
