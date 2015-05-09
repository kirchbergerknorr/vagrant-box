echo "Installing PHP"

apt-get -y install php5
apt-get -y install php5-mhash php5-mcrypt php5-curl php5-cli php5-mysql php5-gd php5-intl php5-common php5-xdebug

echo "
zend_extension=xdebug.so
xdebug.remote_enable = 1
xdebug.remote_host=10.0.2.2
xdebug.idekey=PHPSTORM
" > /etc/php5/mods-available/xdebug.ini

cd /tmp/
wget http://downloads3.ioncube.com/loader_downloads/ioncube_loaders_lin_x86-64.tar.gz
tar xvfz ioncube_loaders_lin_x86-64.tar.gz
PHP_EXT_DIR_STR=$(php -i | grep extension_dir)
PHP_EXT_DIR=$(${PHP_EXT_DIR_STR##*=>})
PHP_VERSION=$(php -r "echo PHP_MAJOR_VERSION.'.'.PHP_MINOR_VERSION;")
#sudo cp "ioncube/ioncube_loader_lin_${PHP_VERSION}.so" ${PHP_EXT_DIR}

#echo "
#zend_extension = ioncube_loader_lin_${PHP_VERSION}.so
#" > /etc/php5/apache2/php.ini

#echo "
#zend_extension = ioncube_loader_lin_${PHP_VERSION}.so
#" > /etc/php5/cli/php.ini

sudo ln -sf /etc/php5/mods-available/mcrypt.ini /etc/php5/apache2/conf.d/20-mcrypt.ini
sudo ln -sf /etc/php5/mods-available/mcrypt.ini /etc/php5/cli/conf.d/20-mcrypt.ini

echo "date.timezone = Europe/Berlin" >> /etc/php5/cli/php.ini

sudo service apache2 restart
