sudo yum -y install build-essential 
#installing apache2
sudo yum -y install apache2
#installing java and supplying yes to every question
sudo yum -y install openjdk-7-jdk
#adding of the logstash repository to the source list
sudo rpm --import http://packages.elasticsearch.org/GPG-KEY-elasticsearch
sudo wget https://raw.githubusercontent.com/meadhikari/logstash/master/logstash.repo -O /etc/yum.repos.d/logstash.repo
#installing logstash
sudo yum -y install logstash
#install redis server
sudo yum -y install redis-server
#changing the redis-server default IP binding
sudo sed -i 's/127.0.0.1/10.0.3.153/g' /etc/redis/redis.conf
#restarting the redis-server after the configuration has been changed
sudo service redis-server restart

#set the environment varialble last word could be i386 or amd64
export JAVA_HOME=/usr/lib/jvm/java-7-openjdk-amd64/
sudo rpm -i https://download.elasticsearch.org/elasticsearch/elasticsearch/elasticsearch-1.0.1.noarch.rpm
#configure elasticsearch yaml file
echo 'cluster.name: logstash' | sudo tee  -a /etc/elasticsearch/elasticsearch.yml 
echo 'node.name: "smoker"' | sudo tee  -a /etc/elasticsearch/elasticsearch.yml 

#downloading of configuration file for the indexer
sudo wget https://raw.githubusercontent.com/meadhikari/logstash/master/sample_indexer.conf -O /etc/logstash/conf.d/central.conf

#downloading the init script for the server
sudo wget https://raw.githubusercontent.com/meadhikari/logstash/master/logstash-shipper-init -O /etc/init.d/logstash-shipper-init
#making the script executable
sudo chmod +x /etc/init.d/logstash-shipper-init
#making it start at boot time
sudo /sbin/chkconfig --add logstash-shipper-init
sudo /sbin/chkconfig logstash-shipper-init on

#working on kibana setup

wget https://download.elasticsearch.org/kibana/kibana/kibana-3.0.0.tar.gz
tar -xvf kibana-3.0.0.tar.gz
sudo mv kibana-3.0.0/ /var/www/kibana


#starting the services
#redis is auto started so we are not using it
sudo service elasticsearch start
sudo service logstash start

