#!/usr/bin/env bash
SCRIPT_PATH="/usr/local/src/hype_machine/bin/"
IP_ADDR=`ip addr | grep 'state UP' -A2 | tail -n1 | awk '{print $2}' | cut -f1  -d'/'`
HYPEM_USERNAME='flog'

echo "Clearing old files"
rm -rf /tmp/hypem/*

mkdir -p /tmp/hypem/{popular,favorites}
cd /tmp/hypem

echo "Downloading Hype Machine Popular tracks"
`${SCRIPT_PATH}/hypem -f 2 -w 10 -o popular /tmp/hypem/popular`

echo "Generating Hype Machine Popular tracks M3U playlist"
for f in /tmp/hypem/popular/*.mp3; do echo "$f" >> /tmp/hypem/popular.m3u; done

echo "Downloading Hype Machine Favourite tracks"
`${SCRIPT_PATH}/hypem -w 10 $HYPEM_USERNAME /tmp/hypem/favorites`

echo "Generating Hype Machine Favourite tracks M3U playlist"
for f in /tmp/hypem/favorites/*.mp3; do echo "$f" >> /tmp/hypem/favorites.m3u; done

echo "Setting playlist to point smb://"
`sed -i 's/tmp/smb:\/\/$IP_ADDR/g' /tmp/hypem/*.m3u`

echo "Done!"
