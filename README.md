<div align=center><img alt="Cover" width="524" height="744" src="assets/illustrations/A5/front-cover.jpg"></div>
</br>
</br>
<p align="center">A collaborative effort from the SBS Saṅgha and members of the four assemblies.</p>
</br>
</br>

# Prerequisites

-   make
-   texlive (the complete TeXLive distribution is preferrable though you may be able to install only the needed binaries depending on your distribution or OS.)
-   [inotify-tools](https://github.com/inotify-tools/inotify-tools)
-   [calibre](https://github.com/kovidgoyal/calibre)
-   java
-   [lxml](https://github.com/lxml/lxml)
-   [epubcheck](https://github.com/w3c/epubcheck)

# `make` Commands

-   `make pdf`: Tangles `recitations.tex.org` to the respective TeX files, builds the PDF, then renames and places the PDF in `build/` . `make pdf2x` does the same just twice over to ensure the hyperlinks are properly set.
-   `make pdfrequirements`: Downloads the tabularray and ninecolors packages and places them in `$TEXMFHOME/tex`.
-   `make epub`: Builds EPUB format; placed in `build/`.
-   `make mobi`: Builds MOBI format with Calibre; placed in `build/`.
-   `make azw3`: Builds AZW3 format with Calibre; placed in `build/`.
-   `make validate`: Builds the EPUB and then checks for errors with epubcheck.
-   `make optimize`
-   `make view`: Opens current.recitations.epub with Calibre&rsquo;s ebook viewer.
-   `make editwatchepub`: Opens current.recitations.epub with Sigil and watches for any errors. Error messages will be shown while editing and epubcheck check is ran after saving.
-   `make clean`: Removes all built documents.
-   `make epub`: Convert HTML hierarchy into EPUB document.
-   `make extractepub`: Extracts EPUB and converts to HTML hierarchy.
-   `make watchepub`: Watches current.recitations.epub for edits and changes.
-   `make release`: Validates and builds all documents.

