div align="center">

# Pāli-English Recitations

A collaborative effort from the SBS Saṅgha and members of the greater community.

![Front Cover](./assets/illustrations/A5/front-cover.jpg)
<!-- ![Doom Emacs Screenshot](https://raw.githubusercontent.com/doomemacs/doomemacs/screenshots/main.png) -->

</div>

## Prerequisites
- make
- texlive (the complete TeXLive distribution is preferrable though you may be able to install only the needed binaries depending on your distribution or OS.)
- [[https://github.com/inotify-tools/inotify-tools][inotify-tools]]
- [[https://github.com/kovidgoyal/calibre][calibre]]
- java
- [[https://github.com/lxml/lxml][lxml]]
- [[https://github.com/w3c/epubcheck][epubcheck]]
- kindlegen

## LaTeX
- [[https://www.ctan.org/pkg/tabularray][Tabularray]]
- [[https://www.ctan.org/pkg/ninecolors][Ninecolors]]

LaTeX prerequisites can be installed on GNU/Linux by simply running =make pdfrequirements=

Otherwise, download the package archives and unzip to =texmf/tex= found in the user home directory. Create the directory if needed.

Linux: =/home/<your-username>/.local/share/texmf/tex=

Windows: =C:\Users\<your-username>\texmf\tex=

## =make= Commands
- =make pdf=: Tangles =recitations.tex.org= to the respective TeX files, builds the PDF, then renames and places the PDF in =build/= . =make pdf2x= does the same just twice over to ensure the hyperlinks are properly set.
- =make pdfrequirements=: Downloads the tabularray and ninecolors packages and places them in =$TEXMFHOME/tex=.
- =make epub=: Builds EPUB format; placed in =build/=.
- =make mobi=: Builds MOBI format with KindleGen; placed in =build/=.
- =make azw3=: Builds AZW3 format with Calibre; placed in =build/=.
- =make validate=: Builds the EPUB and then checks for errors with epubcheck.
- =make optimize=
- =make view=: Opens current.recitations.epub with Calibre's ebook viewer.
- =make editwatchepub=: Opens current.recitations.epub with Sigil and watches for any errors. Error messages will be shown while editing and epubcheck check is ran after saving.
- =make clean=: Removes all built documents.
- =make epub=: Convert HTML hierarchy into EPUB document.
- =make extractepub=: Extracts EPUB and converts to HTML hierarchy.
- =make watchepub=: Watches current.recitations.epub for edits and changes.
- =make release=: Validates and builds all documents.
