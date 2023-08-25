#!/bin/sh

echo Muxing all the video and subtitles together.

shopt -s nullglob

for f in *.MOV;
do
        echo "Re-compressing: $f\n";
        remux-mkv.sh "$f"
done
