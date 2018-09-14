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
wget http://apache.40b.nl/hadoop/common/hadoop-3.1.1/hadoop-3.1.1.tar.gz
tar -xvf hadoop-3.1.1.tar.gz

# download hive
wget www-eu.apache.org/dist/hive/hive-3.1.0/apache-hive-3.1.0-bin.tar.gz
tar -xvf apache-hive-3.1.0-bin.tar.gz

# move hadoop to usr directory
sudo mv hadoop-3.1.1 /usr/local/hadoop
export HADOOP_HOME=/usr/local/hadoop
export PATH=$HADOOP_HOME/bin:$PATH

# move hive to usr directory
sudo mv apache-hive-3.1.0-bin /usr/local/hive
export HIVE_HOME=/usr/local/hive
export PATH=$HIVE_HOME/bin:$PATH
export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64/jre/ && export HADOOP_HOME=/usr/local/hadoop && export PATH=$HADOOP_HOME/bin:$PATH && export HIVE_HOME=/usr/local/hive && export PATH=$HIVE_HOME/bin:$PATH

# create warehouse for hive
hdfs dfs -mkdir -p /root/hive/warehouse
cd /root/hive/warehouse
$HIVE_HOME/bin/schematool -initSchema -dbType derby # run this command the before the first time you start hive 
hive -e 'show databases;'
hdfs dfs -chmod -R 777 /root/hive/warehouse # never do this in a production situation
# mv metastore_db metastore_db.tmp

# test 1: version
cd /usr/local/hadoop
bin/hadoop version

# test 2: Map Reduce
mkdir input
cp etc/hadoop/*.xml input
bin/hadoop jar share/hadoop/mapreduce/hadoop-mapreduce-examples-3.1.1.jar grep input output 'dfs[a-z.]+'
cat output/*

# test 3: HDFS
bin/hdfs classpath

# finally, set environment variables in /etc/profile.d such that user does not have to execute the export commands
cd /etc/profile.d
sudo wget https://raw.githubusercontent.com/rebremer/AzureDevTestLabHadoopSparkOnUbuntuScript/master/Artifacts/HadoopHive/setenvvarHadoopHive.sh