#!/bin/bash
#
# bash script to calculate total mp3 duration from dir
#
# Pierre-Yves Paranthoen nuxsfm@gmail.com, Sept 2019
#
# mediainfo has to be installed
#
# usage : run mp3Duration.sh INTO mp3 directory

shopt -s nullglob
let playlist_duration_ms=0

find . -type f -name '*.mp3' -print0 |
while IFS= read -r -d '' song_file; do
#    printf '%s\n' "$song_file"
    playlist_duration_ms=$(expr $playlist_duration_ms + $(mediainfo --Inform="Audio;%Duration%" "$song_file"))
#    echo $playlist_duration_ms

    let playlist_duration_secs=$(expr $playlist_duration_ms / 1000)
    let playlist_duration_mins=$(expr $playlist_duration_ms / 60000)
    let playlist_duration_hours=$(expr $playlist_duration_mins / 60)
    let playlist_duration_days=$(expr $playlist_duration_hours / 24)

    let playlist_duration_remaining_secs=$(expr $playlist_duration_secs - $(expr $playlist_duration_mins \* 60))
    let playlist_duration_remaining_mins=$(expr $playlist_duration_mins - $(expr $playlist_duration_hours \* 60))
    let playlist_duration_remaining_hours=$(expr $playlist_duration_hours - $(expr $playlist_duration_days \* 24))

    echo $playlist_duration_days days, $playlist_duration_remaining_hours hours, $playlist_duration_remaining_mins minutes, $playlist_duration_remaining_secs seconds

done
