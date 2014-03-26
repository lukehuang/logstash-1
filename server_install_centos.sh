#installing apache2
sudo yum -y install httpd
#installing java and supplying yes to every question
sudo yum -y install java-1.7.0-openjdk
#adding of the logstash repository to the source list
sudo rpm --import http://packages.elasticsearch.org/GPG-KEY-elasticsearch
sudo wget https://raw.githubusercontent.com/meadhikari/logstash/master/logstash.repo -O /etc/yum.repos.d/logstash.repo
#installing logstash
sudo yum -y install logstash
sudo /sbin/chkconfig --add logstash
sudo /sbin/chkconfig logstash on

#install redis server
sudo yum -y update
sudo ln -sf /usr/share/zoneinfo/America/Los_Angeles \/etc/localtime
sudo yum -y install gcc gcc-c++ make 
cd /usr/local/src
sudo wget http://redis.googlecode.com/files/redis-2.6.0-rc5.tar.gz
sudo tar xzf redis-2.6.0-rc5.tar.gz
sudo rm redis-2.6.0-rc5.tar.gz -f
cd redis-2.6.0-rc5
sudo make
sudo mkdir /etc/redis /var/lib/redis
sudo cp src/redis-server src/redis-cli /usr/local/bin
sudo sed -e "s/^daemonize no$/daemonize yes/" -e "s/^# bind 127.0.0.1$/bind 127.0.0.1/" -e "s/^dir \.\//dir \/var\/lib\/redis\//" -e "s/^loglevel verbose$/loglevel notice/" -e "s/^logfile stdout$/logfile \/var\/log\/redis.log/" redis.conf > /etc/redis/redis.conf
wget https://raw.github.com/saxenap/install-redis-amazon-linux-centos/master/redis-server
sudo mv redis-server /etc/init.d
sudo chmod 755 /etc/init.d/redis-server
sudo chkconfig --add redis-server
sudo chkconfig --level 345 redis-server on

#set the environment varialble last word could be i386 or amd64
export JAVA_HOME=/usr/lib/jvm/java-1.7.0-openjdk-1.7.0.51.x86_64/
sudo rpm -i https://download.elasticsearch.org/elasticsearch/elasticsearch/elasticsearch-1.0.1.noarch.rpm
sudo /sbin/chkconfig --add elasticsearch
sudo /sbin/chkconfig elasticsearch on
#configure elasticsearch yaml file
echo 'cluster.name: logstash' | sudo tee  -a /etc/elasticsearch/elasticsearch.yml 
echo 'node.name: "smoker"' | sudo tee  -a /etc/elasticsearch/elasticsearch.yml 

#downloading of configuration file for the indexer
sudo wget https://raw.githubusercontent.com/meadhikari/logstash/master/sample_indexer.conf -O /etc/logstash/conf.d/central.conf

#working on kibana setup
wget https://download.elasticsearch.org/kibana/kibana/kibana-3.0.0.tar.gz
tar -xvf kibana-3.0.0.tar.gz
sudo mv kibana-3.0.0/ /var/www/html/kibana
sudo chown -R apache:apache /var/www/html/kibana

#starting the services
sudo service redis-server start
sudo service elasticsearch start
sudo service logstash start

