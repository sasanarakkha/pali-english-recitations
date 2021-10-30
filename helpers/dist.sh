#!/bin/bash

DOT_GIT_DIR="../bhikkhu-manual.github.io-dot-git"

if [ ! -d "$DOT_GIT_DIR" -o ! -f "$DOT_GIT_DIR/config" ]; then
    echo "Create the HTML repo .git folder as $DOT_GIT_DIR."
    exit 2
fi

if [ -d book ]; then
    mdbook clean
fi

mdbook build

# Relative path is interpreted from symlink target location, i.e. in ./book
ln -s "../$DOT_GIT_DIR" ./book/.git

