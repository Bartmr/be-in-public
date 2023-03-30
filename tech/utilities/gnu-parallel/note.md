Examples:

1. Downloading multiple files in parallel: 

$ ls | parallel wget --no-clobber {}

2. Gzip a folder of files in parallel:

$ ls | parallel gzip {}

3. Convert multiple video files to mp4 in parallel:

$ ls | parallel ffmpeg -i {} {}.mp4