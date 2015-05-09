echo "Installing MySQL"

export DEBIAN_FRONTEND=noninteractive
apt-get -q -y install mysql-server-5.6 mysql-client-5.6
sudo sed -i "s/bind-address.*/bind-address = 0.0.0.0/" /etc/mysql/my.cnf
mysqladmin -u root password toor
sudo mysql -uroot -ptoor --execute "CREATE USER 'root'@'%' IDENTIFIED BY 'toor';"
sudo mysql -uroot -ptoor --execute "GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY 'toor' with GRANT OPTION; FLUSH PRIVILEGES;"
sudo service mysql stop
sudo service mysql start
