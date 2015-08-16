FROM centos:centos6

MAINTAINER Chenmc "maochuan.chen@e-vada.com"

RUN yum install -y wget

RUN yum install -y openssh-clients

RUN wget -O /etc/yum.repos.d/jenkins.repo http://jenkins-ci.org/redhat/jenkins.repo
RUN rpm --import http://pkg.jenkins-ci.org/redhat/jenkins-ci.org.key

RUN yum update -y

RUN rpm -ivh http://download.oracle.com/otn-pub/java/jdk/8u51-b16/jdk-8u51-linux-x64.rpm

RUN sed -i '$a export JAVA_HOME=/usr/java/jdk1.8.0_51' /etc/profile
RUN sed -i '$a export PATH=$JAVA_HOME/bin:$PATH' /etc/profile
RUN sed -i '$a export CLASSPATH=.:$JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar' /etc/profile

RUN source /etc/profile

#安装jenkins
RUN rpm -ivh http://pkg.jenkins-ci.org/redhat/jenkins-1.620-1.1.noarch.rpm

RUN nohup java -jar /usr/lib/jenkins/jenkins.war >jenkins.log &
