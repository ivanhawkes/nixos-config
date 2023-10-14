#!/bin/sh

# Make sure the media drives are online. They don't mount automatically.
#sudo mount /media/mercury
#sudo mount /media/venus
sudo mount -a

echo Back up photos
rsync -va --no-owner --no-group --size-only /media/media/photos/ /media/backup/photos/ --delete

echo Back up anime
rsync -va --no-owner --no-group --size-only /media/media/anime/ /media/backup/anime/ --delete

echo Back up books
rsync -va --no-owner --no-group --size-only /media/media/books/ /media/backup/books/ --delete

echo Back up family media
rsync -va --no-owner --no-group --size-only /media/media/family/ /media/backup/family/ --delete

echo Back up films
rsync -va --no-owner --no-group --size-only /media/media/film/ /media/backup/film/ --delete

echo Back up music
rsync -va --no-owner --no-group --size-only /media/media/music/ /media/backup/music/ --delete

echo Back up tv shows
rsync -va --no-owner --no-group --size-only /media/media/tv-series/ /media/backup/tv-series/ --delete

echo Back up videoclips
rsync -va --no-owner --no-group --size-only /media/media/videoclip/ /media/backup/videoclip/ --delete

echo Back up  audio library.
rsync -va --no-owner --no-group --size-only /media/media/Audio Library/ /media/backup/Audio Library/ --delete

echo Back up software.
rsync -va --no-owner --no-group --size-only /media/media/software/ /media/backup/software/ --delete

echo Back up drivers.
rsync -va --no-owner --no-group --size-only /media/media/drivers/ /media/backup/drivers/ --delete


# FIX PERMISSIONS
#sudo chown -R nobody:nogroup /media/data/ && sudo chmod -R 0775 /media/data/ && sudo chmod -R 0700 /media/data/lost+found/
#sudo chown -R nobody:nogroup /media/media/ && sudo chmod -R 0775 /media/media/ && sudo chmod -R 0700 /media/media/lost+found/
