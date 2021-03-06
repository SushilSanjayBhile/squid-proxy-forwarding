# This shows systemd services (nginx and named) running in a centos7 container.
# There have been lots of problems and workarounds for this, see:
# https://hub.docker.com/_/centos/
# https://github.com/docker/docker/issues/7459

FROM centos:centos7

RUN yum update -y
RUN yum install -y epel-release # for nginx
#RUN yum install -y initscripts  # for old "service"
RUN yum -y update

ENV container=docker

RUN (cd /lib/systemd/system/sysinit.target.wants/; for i in *; do [ $i == systemd-tmpfiles-setup.service ] || rm -f $i; done); \
rm -f /lib/systemd/system/multi-user.target.wants/*;\
rm -f /etc/systemd/system/*.wants/*;\
rm -f /lib/systemd/system/local-fs.target.wants/*; \
rm -f /lib/systemd/system/sockets.target.wants/*udev*; \
rm -f /lib/systemd/system/sockets.target.wants/*initctl*; \
rm -f /lib/systemd/system/basic.target.wants/*;\
rm -f /lib/systemd/system/anaconda.target.wants/*;

# named (dns server) service
RUN yum clean all

RUN yum install -y squid
RUN systemctl enable squid 

# Without this, init won't start the enabled services and exec'ing and starting
# them reports "Failed to get D-Bus connection: Operation not permitted".
VOLUME /run /tmp

# Don't know if it's possible to run services without starting this
CMD /usr/sbin/init
