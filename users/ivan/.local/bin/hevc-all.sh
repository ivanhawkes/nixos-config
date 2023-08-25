#!/bin/sh

echo Muxing all the video and subtitles together.

shopt -s nullglob

for f in *.mkv;
do
        echo "Re-compressing: $f\n";
        hevc.sh "$f"
done
