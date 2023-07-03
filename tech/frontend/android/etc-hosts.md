> From https://forum.xda-developers.com/t/editing-host-file.4345167/

#### FIRST METHOD​

  
First method is by useing Android Debugging Bridge (ADB). Make sure you SDK platform tools ready on your pc.  
1. Open a terminal window in the install folder of platform tools.  
2. Pull the hosts file out of the phone to your PC  

Code:

```
adb pull /system/etc/hosts C:\platform-tools
```

Ofcourse you can change the location of where you want the fille to be pulled to.  
3. Once you have pulled the hosts file to the desired location you can edit it. I will share my hosts file I use on my PC, you can take stuff frome there and integrated it in to yours. But don't put #, " and usles text, It will not like it.  
4. After you have edited the host file to your needs, you need to send it back to your phone.  

Code:

```
adb shell
su
mount -o rw,remount /system
adb push C:\platform-tools\hosts /system/etc/
```

After you type SU a prompt for root_privlages will apear on your phone, allow the shell to have root_privlages. mount -o rw,remount /system will disable SYSTEM on READ_ONLY  
5. After pushing the HOSTS file to your phone put SYSTEM back to READ_ONLY  

Code:

```
mount -o ro,remount /system
```

6. Enoy.  
  

#### SECONED METHOD​

  
Doesn't require root but requires TWRP to be installed.  
1. You will need SDK platform tools  
2. Open a terminal windows in the install folder of platform tools.  
3. Pull the HOST file from the phone  

Code:

```
adb pull /system/etc/hosts C:\platform-tools
```

Ofcourse you can change the location of where you want the fille to be pulled to.  
4. Once you have pulled the hosts file to the desired location you can edit it. I will share my hosts file I use on my PC, you can take stuff frome there and integrated it in to yours. But don't put #, " and usles text, It will not like it.  
5. Transfer your version of the HOSTS file to your sd_card, either by file explorer or ADB  

Code:

```
adb push C:\platform-tools\hosts /sdcard
```

6. Boot in to TWRP and tap on mount, uncheck the option SYSTEM PARTITIONS ON READ_ONLY  
7. Once READ_ONLY is disabled on SYSTEM partition go in to advanced then in to file manager. Copy your hosts file from external_sd card to system\etc\  
8. Reboot and enoy.  
  

#### THIRD METHOD​

  
Requires SDK platform tools and root_privlages  
1. Open terminal window in install folder  
2. Run shell with super user  

Code:

```
adb shell
su
```

You will get a pop up on your phone for shell asking root_premisions you want to click allow.  
3. Remount system and get in to folder of host file  

Code:

```
remount system
cd system
cd etc
```

4. Display the host file in terminal window  

Code:

```
cat hosts
```

5. Manualy edit host file, this is with a example ip  

Code:

```
echo "127.0.0.1  google.com" >> hosts
```

6. You should see this now after running cat hosts  

Code:

```
127.0.0.1       localhost
::1             ip6-localhost
127.0.0.1       google.com
```

7. Exit shell by typing exit