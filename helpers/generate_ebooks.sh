#!/usr/bin/env bash

pwd
MDBOOK_EPUB_BIN=../libs/mdbook-epub

EBOOK_NAME="SBS Pāli-English Recitations"
EPUB_FILE="$EBOOK_NAME.epub"
MOBI_FILE="$EBOOK_NAME.mobi"

# Use book-epub.toml to provide options
mv book.toml book-html.toml
cp book-epub.toml book.toml

# Update the date
cd manuscript/markdown
TODAY=$(date '+%Y-%m-%d at %R:%S')
sed -i 's/\(This version was created on:\) *[0-9-]\{10\}/\1 '"$TODAY"'/' copyright.md
cd ../..

# Use cover-page-ebook.md for a simple title page
cd manuscript/markdown
mv cover-page.md cover-page-html.md
cp cover-page-ebook.md cover-page.md
cd ../..

mdbook-epub --standalone || $MDBOOK_EPUB_BIN --standalone

if [ "$?" != "0" ]; then
    echo "Error, exiting."
    exit 2
fi

# Restore
mv book-html.toml book.toml
cd manuscript/markdown
mv cover-page-html.md cover-page.md
cd ../..

mv "./book/epub/SBS Pāli-English Recitations.epub" "./$EPUB_FILE"

if [ "$?" != "0" ]; then
    echo "Error, exiting."
    exit 2
fi

epubcheck "./$EPUB_FILE"
# TODO find a way to make conditional for these two command, if epubcheck in is in path then run otherwise run relative path to command, same with kindlegen
#java -jar ../libs/epubcheck/epubcheck.jar "./$EPUB_FILE"

if [ "$?" != "0" ]; then
    echo "Error, exiting."
    exit 2
fi

kindlegen "./$EPUB_FILE" -dont_append_source -c1 -verbose
#../libs/kindlegen "./$EPUB_FILE" -dont_append_source -c1 -verbose

if [ "$?" != "0" ]; then
    echo "Error, exiting."
    exit 2
fi

mv "./$EPUB_FILE" "./manuscript/markdown/includes/docs"
mv "./$MOBI_FILE" "./manuscript/markdown/includes/docs"

echo "OK"

