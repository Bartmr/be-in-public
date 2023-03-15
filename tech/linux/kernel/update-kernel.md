- https://kernel.ubuntu.com/~kernel-ppa/mainline/
  - You need to disable Secure Boot since kernel is unsigned
  - sudo apt install ./linux-headers-*.deb ./linux-image-unsigned-*.deb ./linux-modules-*.deb
  - You might get an error that the system is unable to build the modules. If that’s the case, resolve it with:
    ```
    sudo apt-get install gcc make perl -y
    ```
    
- Remove old version
  - sudo apt purge linux-headers-5.15.0* linux-modules-5.15.0* linux-image-unsigned-5.15.0*
  - sudo apt autoremove

- Using `mainline` tool
  - sudo add-apt-repository ppa:cappelikan/ppa
  - sudo apt update
  - sudo apt install -y mainline