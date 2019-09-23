#!/bin/sh

# update ubuntu
sudo apt-get update -y

# install ssh
sudo apt-get install ssh -y
sudo apt-get install rsync -y

# install java
sudo apt-get install openjdk-8-jre -y
export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64/jre/

# download hadoop
# wget http://apache.40b.nl/hadoop/common/hadoop-3.1.1/hadoop-3.1.1.tar.gz
wget http://apache.cs.uu.nl/hadoop/common/hadoop-3.2.0/hadoop-3.2.1.tar.gz
tar -xvf hadoop-3.2.1.tar.gz

# move hadoop to usr directory
sudo mv hadoop-3.2.1 /usr/local/hadoop
export HADOOP_HOME=/usr/local/hadoop
export PATH=$HADOOP_HOME/bin:$PATH

# test 1: version
hadoop version

# test 2: HDFS
hdfs classpath

# finally, set environment variables in /etc/profile.d such that user does not have to execute the export commands
cd /etc/profile.d
sudo wget https://raw.githubusercontent.com/marcospruit/AzureDevTestLabHadoopSparkOnUbuntuScript/master/Artifacts/HadoopHive/setenvvarHadoopHive.sh
