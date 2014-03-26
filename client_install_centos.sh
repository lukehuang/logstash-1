#adding of the logstash repository to the source list
sudo rpm --import http://packages.elasticsearch.org/GPG-KEY-elasticsearch
sudo wget https://raw.githubusercontent.com/meadhikari/logstash/master/logstash.repo -O /etc/yum.repos.d/logstash.repo

#installing logstash
sudo yum install logstash

#download the configuration from the github server different for each type of client but here only for the sample is done
sudo wget https://raw.githubusercontent.com/meadhikari/logstash/master/shipper.conf -O /etc/logstash/conf.d/shipper.conf

#geodb
sudo mkdir /opt/geodb/
sudo wget https://github.com/meadhikari/logstash/raw/master/GeoLiteCity.dat -O /opt/geodb/GeoLiteCity.dat

#add pattern for jetty
sudo wget https://raw.githubusercontent.com/meadhikari/logstash/master/jetty -O /opt/logstash/patterns/jetty
#start in now
sudo service logstash start

#starting the logstash service at startup
sudo /sbin/chkconfig --add mysqld
sudo /sbin/chkconfig mysqld on

