#!/bin/sh

export SOURCE=/media/media
export DEST=/media/backup

# Make sure the media drives are online. They don't mount automatically.
#sudo mount /media/mercury
#sudo mount /media/venus
sudo mount -a

echo Back up photos
rsync -va --no-owner --no-group --size-only $SOURCE/photos/ $DEST/photos/ --delete

echo Back up anime
rsync -va --no-owner --no-group --size-only $SOURCE/anime/ $DEST/anime/ --delete

echo Back up  audio library.
rsync -va --no-owner --no-group --size-only $SOURCE/audio-library/ $DEST/audio-library/ --delete

echo Back up books
rsync -va --no-owner --no-group --size-only $SOURCE/books/ $DEST/books/ --delete

echo Back up datasheets.
rsync -va --no-owner --no-group --size-only $SOURCE/datasheets/ $DEST/datasheets/ --delete

echo Back up drivers.
rsync -va --no-owner --no-group --size-only $SOURCE/drivers/ $DEST/drivers/ --delete

echo Back up family media
rsync -va --no-owner --no-group --size-only $SOURCE/family/ $DEST/family/ --delete

echo Back up films
rsync -va --no-owner --no-group --size-only $SOURCE/film/ $DEST/film/ --delete

echo Back up music
rsync -va --no-owner --no-group --size-only $SOURCE/music/ $DEST/music/ --delete

echo Back up tv shows
rsync -va --no-owner --no-group --size-only $SOURCE/tv-series/ $DEST/tv-series/ --delete

echo Back up videoclips
rsync -va --no-owner --no-group --size-only $SOURCE/videoclip/ $DEST/videoclip/ --delete

echo Back up software.
rsync -va --no-owner --no-group --size-only $SOURCE/software/ $DEST/software/ --delete


# FIX PERMISSIONS
#sudo chown -R nobody:nogroup /media/data/ && sudo chmod -R 0775 /media/data/ && sudo chmod -R 0700 /media/data/lost+found/
#sudo chown -R nobody:nogroup $SOURCE/ && sudo chmod -R 0775 $SOURCE/ && sudo chmod -R 0700 $SOURCE/lost+found/
