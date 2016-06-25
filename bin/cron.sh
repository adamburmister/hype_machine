#!/usr/bin/env bash
SCRIPT_PATH="/usr/local/src/hype_machine/bin/"

echo "Clearing old files"
rm -rf /tmp/hypem/*

mkdir -p /tmp/hypem/{popular,favorites}
cd /tmp/hypem

echo "Downloading Hype Machine Popular tracks"
`${SCRIPT_PATH}/hypem -f 2 -w 10 -o popular /tmp/hypem/popular`

echo "Generating Hype Machine Popular tracks M3U playlist"
for f in /tmp/hypem/popular/*.mp3; do echo "$f" >> /tmp/hypem/popular.m3u; done

echo "Downloading Hype Machine Favourite tracks"
`${SCRIPT_PATH}/hypem -w 10 flog /tmp/hypem/favorites`

echo "Generating Hype Machine Favourite tracks M3U playlist"
for f in /tmp/hypem/favorites/*.mp3; do echo "$f" >> /tmp/hypem/favorites.m3u; done

echo "Setting playlist to point smb://"
sed -i 's/tmp/smb:\/\/192.168.1.110/g' /tmp/hypem/*.m3u

echo "Done!"
