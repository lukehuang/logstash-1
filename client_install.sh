sudo apt-get update
sudo apt-get -y install openjdk-7-jdk
sudo mkdir /var/opt/logstash
cd /var/opt/logstash
sudo wget 54.229.193.9/logstash.jar
sudo wget https://raw.githubusercontent.com/meadhikari/logstash/master/sample_shipper.conf
#java -jar logstash.jar agent --verbose -f sample_shipperconf
