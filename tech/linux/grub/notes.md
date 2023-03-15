## Try out GRUB arguments without persisting them

Add a temporary kernal parameter, which is a one-boot test.

1) Load your grub menu
  - change grub config first (`/etc/default/grub`)
    ```
    GRUB_TIMEOUT="5"
    GRUB_TIMEOUT_STYLE="menu"
    ```
2) Highlight the relevant Linux boot entry
3) Type e to edit
4) On the Linux line, after it says "quiet splash" add i8042.dumbkbd=1

For example:
CODE: SELECT ALL

linux   /boot/vmlinuz-5.8.0-53-generic root=UUID=12345678-1234-5678-9abc-123456789abc ro quiet splash i8042.dumbkbd=1 
5) Press F10 to boot
6) Use cat /proc/cmdline to confirm that parameter was specified
7) If your keyboard worked instantly without delay, then your issue is likely now solved, so proceed to step 2 for a permanent fix.

## Persist GRUB arguments

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
