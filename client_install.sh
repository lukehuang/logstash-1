sudo apt-get update
sudo apt-get -y install openjdk-7-jdk
wget 54.229.193.9/logstash.jar
mkdir logstash
cd logstash
wget 54.229.193.9/logstash.jar
wget https://raw.githubusercontent.com/meadhikari/logstash/master/sample_shipper.conf
#java -jar logstash.jar agent --verbose -f sample_shipperconf
