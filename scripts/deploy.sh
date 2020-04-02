#!/bin/bash

scripts/link-images.sh

echo "Setting permissions..."
find _site/ -type d -exec chmod 755 {} \;
find _site/ -type f -exec chmod 644 {} \;

echo "Syncing to server..."
rsync -a -e "ssh -o StrictHostKeyChecking=no" --delete _site/ matey@man.ubuntu-mate.net:preview.ubuntu-mate.org/
rsync -a -e "ssh -o StrictHostKeyChecking=no" --delete _site/ matey@yor.ubuntu-mate.net:preview.ubuntu-mate.org/

echo "Clearing CDN cache..."
ssh -o StrictHostKeyChecking=no matey@yor.ubuntu-mate.net /home/matey/post-deploy-actions.sh "preview.ubuntu-mate.org"
