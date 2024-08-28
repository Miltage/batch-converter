# finds videos files in current directory and then runs the video conversion script on the file

find -maxdepth 1 -type f -iregex '.*\.\(mp4\|mov\)' -exec bash -c 'sh ~/convert-scripts/convert-video.sh "$0"' {} \;