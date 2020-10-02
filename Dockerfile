FROM ubuntu:16.04


RUN apt-get update
RUN apt-get -y upgrade
RUN apt-get install -y git

RUN apt-get install -y openssh-server
RUN sed -i 's|session    required     pam_loginuid.so|session    optional pam_loginuid.so|g' /etc/pam.d/sshd
RUN mkdir -p /var/run/sshd

RUN apt-get install -y openjdk-8-jdk
ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64

RUN apt-get install -y nodejs

RUN adduser --quiet jenkins

RUN echo "jenkins:jenkins" | chpasswd

EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]
