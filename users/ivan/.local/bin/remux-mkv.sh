#!/bin/sh
# Script to take a video and remux it to the MKV container.
# The resulting file is moved to the media server, and the original files are deleted if
# the conversion is successful.

file=$1
name=${file%.*}
folder="/media/media/recode/"
inputname="$name.MKV"
tempname="$folder$name.mkv"
outputname="$folder$name-hevc.mkv"
pwd="`pwd`/"

echo $pwd
echo Processing $1

if [ -f "$inputname" ]; then
        echo "Converting..."
        cp "$inputname" "$tempname"
        avconv -i "$tempname" -c:v libx265 -x265-params crf=23 -preset fast -c:a copy -metadata:s:a:0 language=eng -c:s copy -metadata:s:s:0 language=eng "$outputname"

        if [ $? -eq 0 ]; then
                echo DELETING ORIGINAL FILES
#               rm -f "$inputname" "$tempname"
#               mv "$outputname" "$pwd$inputname"
        else
                echo Conversion of $file failed.
        fi
fi
