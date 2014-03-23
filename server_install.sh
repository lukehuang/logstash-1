#we need make and gcc so lets install build-essential first
sudo apt-get install build-essential 
#adding of the key of logstash repository
wget -O - http://packages.elasticsearch.org/GPG-KEY-elasticsearch | sudo apt-key add -
#adding of the logstash repository to the source list
sudo sh -c "echo 'deb http://packages.elasticsearch.org/logstash/1.4/debian stable main' > /etc/apt/sources.list.d/logstash.list"
#update the repositories
sudo apt-get update
#install logstash
sudo apt-get -y install logstash
#making the log directory for logstash don't know why this is not automated
sudo mkdir /var/log/logstash
#install redis server
sudo apt-get -y install redis-server
#changing the redis-server default IP binding
sudo sed -i 's/127.0.0.1/10.0.3.153/g' /etc/redis/redis.conf
#restarting the redis-server after the configuration has been changed
sudo service redis-server restart
#downloading the deb file for elasticsearch
wget https://download.elasticsearch.org/elasticsearch/elasticsearch/elasticsearch-1.0.0.deb
#set the environment varialble last word could be i386 or amd64
export JAVA_HOME=/usr/lib/jvm/java-7-openjdk-amd64/
#installing of the deb file
sudo dpkg -i elasticsearch-1.0.0.deb
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
sudo update-rc.d logstash-shipper-init defaults


#working on kibana setup

#installing ruby
sudo apt-get -y install ruby1.9.3
#downloading the kibana tar ball
sudo wget http://162.219.5.213/kibana.tar.gz -O kibana.tar.gz
#extracting the tarball
sudo tar -xvf  kibana.tar.gz
#moving kibana to the directory
sudo mv Kibana-0.2.0/ /var/opt/kibana
#creating a temp directory to hold the pid file
sudo mkdir /var/opt/kibana/tmp
#configuring kibana to accept incoming request from internet
sudo sed -i 's/127.0.0.1/0.0.0.0/g' /var/opt/kibana/KibanaConfig.rb
#changning to the directory
cd /var/opt/kibana
#installing ruby gem bundler
sudo gem install bundler
#installing
sudo bundle install



#init script for kibana
sudo wget https://raw.githubusercontent.com/meadhikari/logstash/master/kibana-init -O /etc/init.d/kibana
sudo chmod +x /etc/init.d/kibana
sudo update-rc.d kibana defaults


