# #!/usr/bin/env bash

sudo apt-get update
sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password password root'
sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password root'
sudo apt-get install -y vim curl python-software-properties
sudo apt-get update
sudo apt-get -y install mysql-server
sudo sed -i "s/^bind-address/#bind-address/" /etc/mysql/my.cnf
mysql -u root -proot -e "GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY 'root' WITH GRANT OPTION; FLUSH PRIVILEGES;"
mysql -u root -proot -e "CREATE DATABASE medicaid;"
sudo /etc/init.d/mysql restart
echo "
[client]
user=root
password=root
database=medicaid
local-infile=1
" > /home/vagrant/.my.cnf

sudo apt-get install unzip

shopt -s nocaseglob
mkdir -p /home/vagrant/medicaid
wget --quiet 'https://data.medicare.gov/views/bg9k-emty/files/Nqcy71p9Ss2RSBWDmP77H1DQXcyacr2khotGbDHHW_s?content_type=application%2Fzip%3B%20charset%3Dbinary&filename=Hospital_Revised_Flatfiles.zip' -O /home/vagrant/medicaid/medicaid.zip
unzip /home/vagrant/medicaid/medicaid.zip -d /home/vagrant/medicaid
rename 's/[ -]+/_/g' /home/vagrant/medicaid/*
mkdir -p /home/vagrant/medicaid/hospital
mv /home/vagrant/medicaid/*hospital* /home/vagrant/medicaid/hospital > /dev/null 2>&1
mv /home/vagrant/medicaid/hospital* /home/vagrant/medicaid/hospital > /dev/null 2>&1



chown -R vagrant:vagrant medicaid/
chown -R vagrant:vagrant .my.cnf

sudo apt-get install -y python-pip

sudo pip install mycli