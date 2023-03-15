- `telnet <IP da máquina>`
  - depois, inserir `root`

- **Telnet** is commonly used by terminal emulation programs that allow you to log into a remote host. SSH serves the same primary function as Telnet but does so in a more secure way. This protocol provides secure access even on unsecured networks, eliminating many of Telnet's vulnerabilities. With SSH, administrators can log into remote devices, execute commands, move files between devices, and more

- `ftp` is a FTP CLI client
  - To login to `ftp` without having an account, use `anonymous`
- `smbclient`

- In Hackthebox, passwords in the machine's services are usually `root`

- `nmap -p- --min-rate 5000 10.129.63.53`
  - Use Nmap to run a port scan, scanning all ports with '-p-'. This can be really slow, so consider adding '--min-rate 5000' or '-T5' to speed it up.

- `redis-cli`
  - `apt-get install redis-tools`
  - `redis-cli -h`
  - https://redis.io/commands/