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
# TODO ensure this works for updating date on copyright.md
cd manuscript/markdown
TODAY=$(date --iso-8601)
sed -i 's/\(This version was created on:\) *[0-9-]\{10\}/\1 '"$TODAY"'/' copyright.md
sed -i 's/\(This version was created on:\) *[0-9-]\{10\}/\1 '"$TODAY"'/' copyright.md
cd ../..

# Use titlepage-ebook.md for a simple title page
cd manuscript/markdown
mv titlepage.md titlepage-html.md
cp titlepage-ebook.md titlepage.md
cd ../..

$MDBOOK_EPUB_BIN --standalone

if [ "$?" != "0" ]; then
    echo "Error, exiting."
    exit 2
fi

# Restore
mv book-html.toml book.toml
cd manuscript/markdown
mv titlepage-html.md titlepage.md
cd ../..

mv "./book/epub/SBS Pāli-English Recitations.epub" "./$EPUB_FILE"

if [ "$?" != "0" ]; then
    echo "Error, exiting."
    exit 2
fi

java -jar ../libs/epubcheck/epubcheck.jar "./$EPUB_FILE"


if [ "$?" != "0" ]; then
    echo "Error, exiting."
    exit 2
fi

../libs/kindlegen "./$EPUB_FILE" -dont_append_source -c1 -verbose

if [ "$?" != "0" ]; then
    echo "Error, exiting."
    exit 2
fi

mv "./$EPUB_FILE" "./manuscript/markdown/includes/docs"
mv "./$MOBI_FILE" "./manuscript/markdown/includes/docs"

echo "OK"

