#!/bin/bash

echo "Convert jpg 300dpi to 92dpi..."

for i in ./photos/300dpi/*.jpg; do
  echo -n "$i ... "
  name=`basename -s .jpg $i`
  convert "$i" -compress jpeg -quality 90 -density 300 -resample 92 ./photos/92dpi/"$name".jpg && \
  if [ "$?" != "0" ]; then
    echo "ERROR"
    exit 2
  fi
  echo "OK"
done

