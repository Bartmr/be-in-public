FROM kalilinux/kali-rolling

RUN apt-get update

RUN apt-get install -y kali-linux-core

RUN apt-get install -y nano python3 python3-pip git

RUN groupadd vscode && useradd --shell /bin/bash --create-home --gid vscode --groups sudo vscode
RUN echo "vscode:Mb921" | chpasswd

USER vscode

CMD ["/bin/bash"]
