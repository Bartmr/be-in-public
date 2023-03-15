## How can I ignore file conflict warnings in apt?

- Replace with new files `apt install -y -o Dpkg::Options::="--force-confdef"`
- Keep old files `apt install -y -o Dpkg::Options::="--force-confold"`