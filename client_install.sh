#lets update first
sudo apt-get update
#installing java and supplying yes to every question
sudo apt-get -y install openjdk-7-jdk
#makr a directory to place logstash file
sudo mkdir /var/opt/logstash
#change to the directory
cd /var/opt/logstash
#downnload the jar file from our server
sudo wget 54.229.193.9/logstash.jar
#download the configuration from the github server different for each type of client but here only for the sample is done
sudo wget https://raw.githubusercontent.com/meadhikari/logstash/master/sample_shipper.conf
#starting the shipper
#java -jar logstash.jar agent --verbose -f sample_shipperconf
