FROM atomicorp/openvas:v9

RUN yum-config-manager --disable TeXLive

RUN yum install --setopt=appstream.baseurl=https://vault.centos.org/8.5.2111/AppStream/x86_64/os/ --setopt=baseos.baseurl=https://vault.centos.org/8.5.2111/BaseOS/x86_64/os/ -y \
  epel-release \
  && yum install -y openvpn