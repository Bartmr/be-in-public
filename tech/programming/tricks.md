## Find and replace in file names

`find / -name '*hello*' -exec rename 's/hello/replacement/' {} \;`