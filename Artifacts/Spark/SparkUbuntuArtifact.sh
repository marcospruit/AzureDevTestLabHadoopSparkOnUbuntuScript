#!/bin/sh

# update ubuntu
sudo apt-get update -y

# install java
sudo apt-get -y install openjdk-8-jre
export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64/jre/

# download spark
wget http://apache.cs.uu.nl/spark/spark-2.3.1/spark-2.3.1-bin-hadoop2.7.tgz
tar -xvf spark-2.3.1-bin-hadoop2.7.tgz

# install spark
sudo mv spark-2.3.1-bin-hadoop2.7 /usr/local/
sudo ln -s /usr/local/spark-2.3.1-bin-hadoop2.7/ /usr/local/spark
cd /usr/local/spark

# start spark
export SPARK_HOME=/usr/local/spark
sudo $SPARK_HOME/sbin/start-master.sh

# finally, set environment variables in /etc/profile.d such that user does not have to execute the export commands
cd /etc/profile.d
sudo wget https://raw.githubusercontent.com/rebremer/AzureDevTestLabHadoopSparkOnUbuntuScript/master/Artifacts/Spark/setenvvarSpark.sh
