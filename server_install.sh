#adding of the key of logstash repository
wget -O - http://packages.elasticsearch.org/GPG-KEY-elasticsearch | sudo apt-key add -
#adding of the logstash repository to the source list
sudo sh -c "echo 'deb http://packages.elasticsearch.org/logstash/1.4/debian stable main' > /etc/apt/sources.list.d/logstash.list"
#update the repositories
sudo apt-get update
#install logstash
sudo apt-get install logstash
#install redis server
sudo apt-get install redis-server
#changing the redis-server default IP binding
sudo sed -i 's/127.0.0.1/10.0.3.153/g' /etc/redis/redis.conf
#downloading the deb file for elasticsearch
wget https://download.elasticsearch.org/elasticsearch/elasticsearch/elasticsearch-1.0.0.deb
#set the environment varialble last word could be i386 or amd64
export JAVA_HOME=/usr/lib/jvm/java-7-openjdk-amd64/
#installing of the deb file
sudo dpkg -i elasticsearch-1.0.0.deb
#configuring the elasticsearch configuration file
echo "cluster.name: logstash" >> /etc/elasticsearch/elasticsearch.yml
echo 'node.name: "smoker"' >> /etc/elasticsearch/elasticsearch.yml
#downloading of configuration file for the indexer
sudo wget https://github.com/meadhikari/logstash/blob/master/sample_indexer.conf -O /etc/logstash/conf.d/central.conf




