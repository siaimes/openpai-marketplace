./rmi.sh
cd webportal_plugin
sudo docker build -t siaimes_webportal_plugin:v1.2.0 .
cd ../rest_server
sudo docker build -t siaimes_rest_server:v1.2.0 .
