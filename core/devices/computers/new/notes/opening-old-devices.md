- Mounting old encrypted hard drive as external drive
  - https://askubuntu.com/questions/766048/mount-unknown-filesystem-type-lvm2-member
  - You used the exact same name (ubuntu-vg) for your new volume group as the old volume group. You must give them unique names You can rename one of the groups using vgrename and its UUID. Find the UUID with vgdisplay and then rename the volume group:
    ```
    vgdisplay
    vgrename <VG UUID> new_name
    ```