# Generate ebooks script for Windows

# Powershell is necessary in order for Calibre's ebook-convert.exe to be accessible after Calibre install.

..\libs\mdbook-epub.exe --standalone

mv '.\book\epub\Sasanarakkha Recitations Book.epub' 'Sasanarakkha Recitations Book.epub'

ebook-convert.exe 'Sasanarakkha Recitations Book.epub' 'Sasanarakkha Recitations Book.mobi'
