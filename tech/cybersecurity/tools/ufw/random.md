- <https://ubuntu.com/server/docs/security-firewall>
- <https://wiki.ubuntu.com/UncomplicatedFirewall>
- <https://www.cherryservers.com/blog/how-to-configure-ubuntu-firewall-with-ufw#:~:text=By%20default%20UFW%20will%20block,connect%20to%20your%20server%20anymore.&text=This%20firewall%20rule%20allows%20TCP%20connections%20to%20port%204422.>
- <https://www.digitalocean.com/community/tutorials/how-to-setup-a-firewall-with-ufw-on-an-ubuntu-and-debian-cloud-server>
- https://hackernoon.com/understanding-ufw-8d70d5d8f9d2
- https://medium.com/@jasonrigden/a-guide-to-the-uncomplicated-firewall-ufw-for-linux-570c3774d7f4

## Commands

- Show open ports: `sudo ufw show listening`
- Configs are in `/etc/ufw`
  - before rules `/etc/ufw/before.rules`
- View status: `sudo ufw status` or `sudo ufw status verbose`
- View information and rules: 
  - `sudo ufw show <one of the options below>`
    - raw
    - builtins
    - before-rules
    - user-rules
    - after-rules
    - logging-rules
    - listening
    - added