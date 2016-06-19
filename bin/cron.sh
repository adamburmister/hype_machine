#!/usr/bin/env bash

mkdir -p /tmp/hypem
cd /tmp/hypem

echo "Clearing old files"
rm -rf /tmp/hypem/*

echo "Downloading Hype Machine Popular tracks"
./hypem -f 2 -w 10 popular /tmp/hypem/

echo "Generating Hype Machine Popular tracks M3U playlist"
for f in *.mp3; do echo "$f" >> play.m3u; done

echo "Done!"
