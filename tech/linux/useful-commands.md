## OS cleanup:

Cleanup systemmd journal at /var/log/journal:

by days older than:
`sudo journalctl --vacuum-time=10d`

Delete all stuff in Trash:
`sudo rm -rf ~/.local/share/Trash /root/.local/share/Trash`

## File Operations:

Permissions:
- https://pplware.sapo.pt/linux/esqueca-o-chmod-777-aprenda-a-definir-permissoes-em-linux/
- change permissions: `chmod`
- change owner: `chown`

Count all files in folder:
`find . -type f | wc -l`

Gain permission over files:
`sudo chmod -R 777`

Encrypt a file
`gpg -c important.docx`

Decrypt a file
`gpg important.dox.gpg`

## Checksums:

MD5 all directory files:
`find -type f \( -not -name "md5sum.txt" \) -exec md5sum '{}' \; > md5sum.txt`

Check back directory:
`md5sum -c md5sum.txt`

## Processes

List all services:
`service --status-all`

## Network

- See what process is using a port: `lsof -i :80`
- Switch network adapters
  - Get adapters names: `ifconfig`
  - `sudo ifconfig wlan1 down`
  - `sudo ifconfig wlan2 up`
  - `sudo service network-manager restart`
  - Restart internal adapter again
    - `sudo ifconfig wlan1 up`
    - `sudo service network-manager restart`

## Images
- Optimize images
  - ImageMagick
    - `convert 01.jpg -resize x1024 -quality 80 01.jpg`
    - `convert '*.jpg' -set filename:fn '%[basename]' -resize x1024 -quality 80 '%[filename:fn].jpg'`

## Others

- Record Screen: `Ctrl+Alt+Shift+R`
- GNU Parallel
  - https://www.gnu.org/software/parallel/parallel.html

## Git
- Revert a merge: `git reset --merge HEAD~1`

## Fonts
- Install fonts by moving them to `~/.fonts` and then running `fc-cache -f -v`
  - https://wiki.ubuntu.com/Fonts

## Users

- Remove user: `userdel -r user`

## Dependencies

- Find the dependency that includes a certain file `apt-file search /netlink/genl/genl.h`

## Devices

- `ls /sys/bus/usb/devices`
- `lsusb -t`
  - Tells lsusb to dump the physical USB device hierarchy as a tree. Verbosity can be increased twice with the v option.
- Get `/dev` file for USB Device
  - 
    lsusb shows the bus and device ids for each device, e.g.

    ```
    Bus 003 Device 005: ID 046d:c24e Logitech, Inc. G500s Laser Gaming Mouse
    ```
    which translates to `/dev/bus/usb/003/005`
  -
    the lsusb command is really just a nice wrapper around sysfs

    ```
    $ lsusb -v
    Bus 001 Device 003: ID 8564:4000 Transcend Information, Inc.
    ```
    Which correlates to
    ```
    /sys/bus/usb/devices/1-3/
    ```
    Notice the device path is 1-3, which correlates to Bus 001 AND Device 003. There is a lot of information you can see in the sysfs device path.