- Model: `HP Spectre x360 Convertible 14-ea1003np`
  - `HP Spectre x360 14` referenced in the Linux kernel code
    - https://github.com/torvalds/linux/blob/master/sound/pci/hda/patch_realtek.c
- This computer came with `Windows 11 Home` out of the box.
-
  - `sudo nano /etc/default/grub`
  - `GRUB_CMDLINE_LINUX_DEFAULT="quiet splash acpi_osi='Windows 2021'"`
    - https://discovery.endeavouros.com/acpi-kernel-parameters/acpi-kernel-parameters-and-how-to-choose-them/2021/03/
    - https://learn.microsoft.com/en-us/windows-hardware/drivers/acpi/winacpi-osi
    - available acpi_osi
        ```
        Windows 2015 	Windows 10
        Windows 2016 	Windows 10, version 1607
        Windows 2017 	Windows 10, version 1703
        Windows 2017.2 	Windows 10, version 1709
        Windows 2018 	Windows 10, version 1803
        Windows 2018.2 	Windows 10, version 1809
        Windows 2019 	Windows 10, version 1903
        Windows 2020 	Windows 10, version 2004
        Windows 2021 	Windows 11
        Windows 2022 	Windows 11, version 22H2
        ```
      - Most common acpi_osi strings are "Windows 2009" (Windows 7), "Windows 2013" (Windows 8.1), "Windows 2015" (Windows 10) and "Windows 2020" (Windows 10)
      - https://unix.stackexchange.com/questions/246672/how-to-set-acpi-osi-parameter-in-the-grub
        ```
        acpi_osi=! acpi_osi="Windows 2009"
        The first part, acpi_osi=! , means "forget any acpi_osi strings that you know at this point" (it's actually a list of strings, rather than just one string, apparently - duh). So we first clear whatever the interpretter originally used, and then set the one desired string. To make it work with a modern Linux kernel, it might be a good idea to specify the most modern Windows version that the BIOS nominally supports.
        ```
      - https://forum.manjaro.org/t/how-to-choose-the-proper-acpi-kernel-argument/1405
        - 
          ```
          Note on acpi_osi=!

          This argument disables all vendor strings that maybe present. It should only be used if one of the above OSI strings does not work on its own. If you use it when it is not needed, you maybe able to boot without any acpi errors, but your touchpad or wifi will not work. It also must be used in combination one of the above OSI strings.
          ```
      - 
        ```
        acpi_osi=!*             # remove all strings
        acpi_osi=!              # disable all built-in OS vendor strings
        ```
      - https://askubuntu.com/questions/28848/what-does-the-kernel-boot-parameter-set-acpi-osi-linux-do
  - `sudo update-grub`
  - Check if config is working with `cat /proc/cmdline`
  - Restart computer twice
- PC hibernates instead of suspending. Might need acpi_osi change
- Related PCs
  - HP-ENVY-x360
- Audio
  - https://askubuntu.com/questions/1410404/hdajackretask-not-saving-changes-after-clicking-install-boot-override
  - Pin override
    - https://askubuntu.com/questions/899021/how-to-fix-bang-and-olufsen-audio-for-hp-laptops/1120269#1120269
    - Override pin 0x14 and set it to Internal Speaker (LFE). I believe this enables the amplifier that drives the top speakers. Setting it to something other than just "Internal Speaker" is important, so that pulseaudio does not try to redirect sound to that channel.
    - Override pin 0x1e and set them to "Internal Speaker".
    - `hdajackretask` from `alsa-tools-gui` 
    - Needs `CONFIG_SND_HDA_PATCH_LOADER=y` in the kernel compilation options to remap the pins
      - https://www.kernel.org/doc/html/v5.0/sound/hd-audio/notes.html
      - https://community.frame.work/t/some-notes-on-audio-in-linux/8815/6
    - Suggested pins config
      ```
      0x12 0x411111f0
      0x13 0x40000000
      0x14 0x90170151
      0x17 0x90170110
      0x18 0x411111f0
      0x19 0x04a11040
      0x1a 0x411111f0
      0x1b 0x411111f0
      0x1d 0x40600001
      0x1e 0x90170150
      0x21 0x04211020
      ```
    - Related
      - https://bugzilla.kernel.org/show_bug.cgi?id=189331
      - https://ubuntuforums.org/showthread.php?t=2414086&page=2
        ```
        0x12 0x411111f0
        0x13 0x40000000
        0x14 0x90170151
        0x16 0x411111f0
        0x17 0x90170110
        0x18 0x411111f0
        0x19 0x04a110c0
        0x1a 0x411111f0
        0x1b 0x411111f0
        0x1d 0x40600001
        0x1e 0x90170150
        0x21 0x04211020
        ```
      - https://askubuntu.com/a/1424585
        ```
        Pin name 	Pin ID 	Drop-down list option
        Not connected 	0x12 	Not connected
        Not connected 	0x13 	Not connected
        Not connected 	0x14 	Internal speaker (LFE)
        Not connected 	0x16 	Not connected
        Internal Speaker 	0x17 	Internal speaker
        Not connected 	0x18 	Not connected
        Black Mic, Left side 	0x19 	Microphone
        Not connected 	0x1a 	Not connected
        Not connected 	0x1b 	Not connected
        Not connected 	0x1d 	Not connected
        Not connected 	0x1e 	Internal speaker
        Black Headphone, Left side 	0x21 	Headphone
        ``` 
  - 
    - https://github.com/thesofproject/alsa-ucm-conf
    - https://github.com/thesofproject/sof
    - https://github.com/thesofproject/sof-bin
  - https://github.com/torvalds/linux/blob/master/sound/pci/hda/patch_realtek.c
  - Consider using `hda` driver. and not `sof`
  - 
    Realtek ALC245: `/sys/class/sound/hwC0D0/user_pin_configs`
    Intel Tigerlake HDMI: `/sys/class/sound/hwC0D2/user_pin_configs`
  - Rewiring pins manually
    ```bash
    #!/bin/sh
    echo "0x12 0x411111f0" | tee /sys/class/sound/hwC0D0/user_pin_configs 2>>/tmp/hda-jack-retask-GB1MX1/errors.log
    echo "0x13 0x40000000" | tee /sys/class/sound/hwC0D0/user_pin_configs 2>>/tmp/hda-jack-retask-GB1MX1/errors.log
    echo "0x14 0x90170151" | tee /sys/class/sound/hwC0D0/user_pin_configs 2>>/tmp/hda-jack-retask-GB1MX1/errors.log
    echo "0x17 0x90170110" | tee /sys/class/sound/hwC0D0/user_pin_configs 2>>/tmp/hda-jack-retask-GB1MX1/errors.log
    echo "0x18 0x411111f0" | tee /sys/class/sound/hwC0D0/user_pin_configs 2>>/tmp/hda-jack-retask-GB1MX1/errors.log
    echo "0x19 0x04a11040" | tee /sys/class/sound/hwC0D0/user_pin_configs 2>>/tmp/hda-jack-retask-GB1MX1/errors.log
    echo "0x1a 0x411111f0" | tee /sys/class/sound/hwC0D0/user_pin_configs 2>>/tmp/hda-jack-retask-GB1MX1/errors.log
    echo "0x1b 0x411111f0" | tee /sys/class/sound/hwC0D0/user_pin_configs 2>>/tmp/hda-jack-retask-GB1MX1/errors.log
    echo "0x1d 0x40600001" | tee /sys/class/sound/hwC0D0/user_pin_configs 2>>/tmp/hda-jack-retask-GB1MX1/errors.log
    echo "0x1e 0x90170150" | tee /sys/class/sound/hwC0D0/user_pin_configs 2>>/tmp/hda-jack-retask-GB1MX1/errors.log
    echo "0x21 0x04211020" | tee /sys/class/sound/hwC0D0/user_pin_configs 2>>/tmp/hda-jack-retask-GB1MX1/errors.log
    echo 1 | tee /sys/class/sound/hwC0D0/reconfig 2>>/tmp/hda-jack-retask-GB1MX1/errors.log
    ```
  - https://github.com/thesofproject/sof/issues/2181
  - https://forum.manjaro.org/t/hp-spectre-2020-speakers-not-working-the-headphones-do/44270/29
  - https://askubuntu.com/questions/1263178/20-04-no-speaker-audio-on-hp-spectre-x360-2020-15t-eb000
  - Linux Kernel quirk commits
    - c3bb2b521944ffbbc8c24b849f81977a9915fb5e
- Tablet
- Auto Rotation
  Installing iio-sensor-proxy and screenrotator-gitAUR, autorotation works out of the box except for pen input (does not get rotated). Instead of screenrotator-git, you can use this script which auto rotates the touchpad, touch screen, and pen.
  - Laptop wakes up with wrong orientation
- Touchscreen Pressure Sensitivity
  The touchscreen seems to use the libinput driver by default, with which pressure sensitivity with the included HP Pen does not work. To get pressure sensitivity install xf86-input-evdev and force the use of the evdev driver:
  ```
  /etc/X11/xorg.conf.d/50-touchscreen.conf
  Section "InputClass"
      Identifier "Touchscreen"
      MatchDevicePath "/dev/input/event11"
      Driver "evdev"
  EndSection
  ```
  The touchscreen should be at /dev/input/event11, but to make sure you can use a utility like evtest and verify the location of your touchscreen by testing the input events.
- Pen
  - Test if pressure and others work
    - `sudo apt-get install evemu-tools evtest`
    - `sudo evtest`
  - Vinha com caneta `Caneta Tilt Pen HP com recarregável MPP2.0` na caixa
    - `MPP` means `Microsoft Pen Protocol`
- Power
  - Suspension and hibernation
    - `/sys/power/state` and `/sys/power/mem_sleep`
- Keyboard
  - keyboard is locked for 30 seconds after powering on or waking up the computer
    - touching the screen with your finger seems to activate the keyboard right away
      - ~~the trick is swiping or double tapping the screen~~
      - the trick is swiping from bottom to top
  - https://forums.linuxmint.com/viewtopic.php?f=49&t=366495
    - Add `i8042.dumbkbd=1` to kernel arguments 
    ```
    Thank you VERY much. I followed the steps and links from your link, and it's worked beautifully. I rebooted and suspended 3 times each, and the keyboard worked instantly on all occasions. The only tiny downside is the caps-lock LED no longer works. But who cares about that?

    I used information gathered from a couple of threads, and some posts from another forum. So in case anybody else has this problem, I shall bring all that info together here and set out my exact steps below.

    Step 1

    Add a temporary kernal parameter, which is a one-boot test.

    1) Load your grub menu
    2) Highlight the relevant Linux boot entry
    3) Type e to edit
    4) On the Linux line, after it says "quiet splash" add i8042.dumbkbd=1

    For example:
    CODE: SELECT ALL

    linux   /boot/vmlinuz-5.8.0-53-generic root=UUID=12345678-1234-5678-9abc-123456789abc ro quiet splash i8042.dumbkbd=1 
    5) Press F10 to boot
    6) Use cat /proc/cmdline to confirm that parameter was specified
    7) If your keyboard worked instantly without delay, then your issue is likely now solved, so proceed to step 2 for a permanent fix.


    Step 2

    Add a permanent kernal parameter.

    1) Use sudo nano /etc/default/grub
    2) You should now see a line which reads:
    CODE: SELECT ALL

    GRUB_CMDLINE_LINUX_DEFAULT="quiet splash"
    3) Edit it to read:
    CODE: SELECT ALL

    GRUB_CMDLINE_LINUX_DEFAULT="quiet splash i8042.dumbkbd=1"
    4) Save the file. This is where I was slightly stumped. In the end I hit ctrl + s, then shut Terminal using the red x. When the warning said "There is still a process running in the terminal. Closing the terminal will kill it". I clicked on "Close Terminal". This worked for me, although I have no idea if this was the precise action I should have taken. Perhaps you know better than me.
    5) Run sudo update-grub
    6) Reboot
    7) Use cat /proc/cmdline to confirm that parameter was specified.
    8) Enjoy feelings of triumph as your keyboard now works normally, except for the caps-lock LED light.
    ```
- https://wiki.archlinux.org/title/HP_Spectre_x360_13-ap0xxxx
- https://wiki.archlinux.org/title/HP_Spectre_x360_(2020)
- Docker images
  - Update them to Ubuntu 22
  - Connect Wayland to host, instead of X11
    - https://github.com/mviereck/x11docker/wiki/How-to-provide-Wayland-socket-to-docker-container
  - Use Wayland in chrome
    - chrome flag `ozone-platform-hint`
    - test screen-sharing afterwards