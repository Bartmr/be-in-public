- `~/snap/sosumi/common/launch` contains the launch configs


## Setup <https://www.youtube.com/watch?v=QWZ_LjzT39k&t=219s>

- Install `sudo apt install qemu-utils`
- `qemu-img resize ~/snap/sosumi/common/macos.qcow2 +20G`
- 
  ```bash
  #!/bin/bash

  OSK="ourhardworkbythesewordsguardedpleasedontsteal(c)AppleComputerInc"

  "$SNAP"/usr/bin/qemu-system-x86_64 \
      -enable-kvm \
  # RAM
  #   -m 2G \
      -m 6G \
      -machine q35,accel=kvm \
  # CPU cores
  #   -smp 4,cores=2 \
      -smp 4,cores=4 \
      -cpu Penryn,vendor=GenuineIntel,kvm=on,+sse3,+sse4.2,+aes,+xsave,+avx,+xsaveopt,+xsavec,+xgetbv1,+avx2,+bmi2,+smep,+bmi1,+fma,+movbe,+invtsc \
      -device isa-applesmc,osk="$OSK" \
      -smbios type=2 \
      -object rng-random,id=rng0,filename=/dev/urandom -device virtio-rng-pci,rng=rng0 \
      -serial mon:stdio \
      -drive if=pflash,format=raw,readonly,file="$SNAP"/firmware/OVMF_CODE.fd \
      -drive if=pflash,format=raw,file="$SNAP_USER_COMMON"/firmware/OVMF_VARS-1024x768.fd \
      -device virtio-vga,virgl=on \
      -display sdl,gl=on \
      -L "$SNAP"/usr/share/seabios/ \
      -L "$SNAP"/usr/lib/ipxe/qemu/ \
      -audiodev pa,id=pa,server="/run/user/$(id -u)/pulse/native" \
      -device ich9-intel-hda -device hda-output,audiodev=pa \
      -usb -device usb-kbd -device usb-mouse \
      -netdev user,id=net0 \
      -device vmxnet3,netdev=net0,id=net0 \
      -drive id=ESP,if=virtio,format=qcow2,file="$SNAP_USER_COMMON"/ESP.qcow2 \
      -drive id=InstallMedia,format=raw,if=virtio,file="$SNAP_USER_COMMON"/BaseSystem/BaseSystem.img \
      -drive id=SystemDisk,if=virtio,file="$SNAP_USER_COMMON"/macos.qcow2 \
  ```
- Run `sosumi`
- Go to `Disk Utility`
  - Erase the first block inside the `Internal` section, called `Apple Inc. VirtIO Block Media`
  - Name it `MacOS`
- Install MacOS
- After restart, select the last black square from the bootloader list called `Boot from MacOS`
- Passthrough USB devices
  - list usb devices with `lsusb` and take note of the ID of the device (`12ab:34cd`)
  - list buses and ports with `lsusb -t`
  - allow snap package to access usb 
    - `snap interfaces sosumi`
    - `sudo snap connect sosumi:raw-usb`
  - go back to `launch` file and add
    - 
      ```
      -device usb-host,vendorid=0x12ab,productid=0x34cd \
      ```
  - in case it doesn't work, add permissions to the bus and port
    - bus and device are the numbers as seen in `lsusb`
    - `sudo chmod a+w /dev/bus/usb/<bus>/<device>`
- Some nice manuals
  - https://github.com/foxlet/macOS-Simple-KVM/blob/master/docs/guide-screen-resolution.md