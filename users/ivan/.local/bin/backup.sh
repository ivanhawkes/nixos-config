#!/bin/sh

echo Back up anime
rsync -va --no-owner --no-group --size-only /media/media/anime/ /mnt/venus/media/anime/ --delete

echo Back up family media
rsync -va --no-owner --no-group --size-only /media/media/family/ /mnt/venus/media/family/ --delete

echo Back up films
rsync -va --no-owner --no-group --size-only /media/data/film/ /mnt/venus/media/film/ --delete

echo Back up music
rsync -va --no-owner --no-group --size-only /media/media/music/ /mnt/venus/media/music/ --delete

echo Back up photos.
rsync -va --no-owner --no-group --size-only /media/media/photos/ /mnt/venus/media/photos/ --delete

echo Back up training videos
rsync -va --no-owner --no-group --size-only /media/media/training/ /mnt/venus/media/training/ --delete

echo Back up tv shows
rsync -va --no-owner --no-group --size-only /media/media/tv-series/ /mnt/mercury/media/tv-series/ --delete

echo Back up videoclips
rsync -va --no-owner --no-group --size-only /media/media/videoclip/ /mnt/venus/media/videoclip/ --delete


# FIX PERMISSIONS
sudo chown -R ivan:ivan /media/data/ && sudo chmod -R 0775 /media/data/ && sudo chmod -R 0700 /media/data/lost+found/
sudo chown -R ivan:ivan /media/media/ && sudo chmod -R 0775 /media/media/ && sudo chmod -R 0700 /media/media/lost+found/

