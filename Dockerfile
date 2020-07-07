FROM centos:latest
RUN dnf update -y
RUN dnf install python3 python3-pip python3-devel krb5-devel krb5-libs krb5-workstation -y
RUN dnf groupinstall 'Development Tools' -y
RUN pip3 install ansible
RUN pip3 install pywinrm
RUN pip3 install pywinrm[kerberos]
RUN  mkdir /root/.ssh
COPY id_rsa /root/.ssh/
COPY config /root/.ssh/
RUN chmod 700 /root/.ssh
RUN chmod 600 /root/.ssh/*