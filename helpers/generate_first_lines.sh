#!/bin/bash

OUT_FILE=./manuscript/markdown/first-lines.md
LINKS_FILE=./temp.md

for i in ./manuscript/markdown/chants/*.md; do
    echo "$i"
    export linktarget=$(echo -n "$i" | sed -e 's/\.\/manuscript\/markdown\///; s/\.md$/.html/;')

    cat "$i" |\
        perl -0777 -pe "s/\n<div class=\"instr\">(.*?)<\/div>//gs" |\
        grep -vE '^> [[]|^> \(|^> Solo|^\*.*\*$' |\
        grep -vE '^\*\*[0-9]+\.\*\*\\$' |\
        grep -E '.' |\
        grep -v '## Closing Sequence<a id="closing"></a>' |\
        grep -v '## Invitations<a id="invitations"></a>' |\
        grep -v '## Core Sequence<a id="core"></a>' |\
        grep -v '## Introductory Chants<a id="introductory"></a>' |\
        grep -v '## Devotional Chants<a id="devotional"></a>' |\
        sed 's/^# /\n&/' |\
        sed -e 's/\\$//; s/[,\.:]$//; s/[[]//g; s/[]]//g; s/ *--\+ *//g;' |\
        sed 's/(The Buddha)/The Buddha/;' |\
        sed "s/'well expounded,'/well expounded/" |\
        perl -0777 -pe "s/\n# (.*?)## /\n## /gs" |\
        perl -0777 -pe "s/\n##.*id=\"([^\"]+)\".*\n(.*)\n/\n- [\2](#\1)\n/g" |\
        grep -E '^- ' |\
        sed 's/[[]> /[/' |\
        sed -e "s/[[]'/[/; s/'[]]/]/;" |\
        perl -0777 -pe 's/[]]\(/]($ENV{linktarget}/g' |\
        grep -v -i -f ./helpers/first_line_filters |\
        cat -s >> "$LINKS_FILE"
done

echo -e "# List of First Lines\n" > "$OUT_FILE"

cat ./helpers/first_line_add >> "$LINKS_FILE"

cat "$LINKS_FILE" | sort | uniq >> "$OUT_FILE"

rm "$LINKS_FILE"


