FROM kalilinux/kali-rolling

RUN apt-get update

RUN apt install -y sudo

RUN apt install -y net-tools

RUN apt install -y pciutils aircrack-ng

RUN apt-get install -y procps iptables \
  gcc \
	python3-setuptools hostapd dnsmasq  openssl libnl-3-dev libnl-genl-3-dev libssl-dev \
  tcpdump \
  isc-dhcp-server

RUN pip3 install six

RUN groupadd vscode && useradd --shell /bin/bash --create-home --gid vscode --groups sudo vscode
RUN echo "vscode:Mb921" | chpasswd

USER vscode

WORKDIR /home/vscode/cybersec

CMD [ "/bin/bash" ]