## Vulnerable points in Docker containers

- volumes
- devices
- capabilities (like SYS_ADMIN)
- privileged mode
- seccomp / apparmor policies
- running user
  - is running user root
  - if running as non-root
    - does it have sudo? Is sudo locked with a password
