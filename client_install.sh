#adding of the key of logstash repository
wget -O - http://packages.elasticsearch.org/GPG-KEY-elasticsearch | sudo apt-key add -
#adding of the logstash repository to the source list
sudo sh -c "echo 'deb http://packages.elasticsearch.org/logstash/1.4/debian stable main' > /etc/apt/sources.list.d/logstash.list"
#update the repositories
sudo apt-get update
#install logstash
sudo apt-get -y install logstash

#download the configuration from the github server different for each type of client but here only for the sample is done
sudo wget https://raw.githubusercontent.com/meadhikari/logstash/master/shipper.conf -O /etc/logstash/conf.d/shipper.conf

#geodb
sudo mkdir /opt/geodb/
sudo wget https://github.com/meadhikari/logstash/raw/master/GeoLiteCity.dat -O /opt/geodb/GeoLiteCity.dat

#add pattern for jetty
sudo wget https://raw.githubusercontent.com/meadhikari/logstash/master/jetty -O /opt/logstash/patterns/jetty
#start in now
sudo service logstash start
#start it at every system startup
sudo update-rc.d logstash defaults

