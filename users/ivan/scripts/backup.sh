#!/bin/bash
echo "Did you mount the drives first? CTRL-C if you forgot."
read

echo "Let the feast of a thousand beasts begin!"
rsync -va --no-owner --no-group --size-only --exclude 'lost+found' --exclude 'torrent' --exclude '.Trash-1000' /media/media/ /media/ivan/backup/media --delete
