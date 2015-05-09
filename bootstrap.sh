# This script can be used to perform any sort of command line actions to setup your box.
# This includes installing software, importing databases, enabling new sites, pulling from
# remote servers, etc.

echo "Configuring SSH"

cp /vagrant/id_rsa /home/vagrant/.ssh/id_rsa
cat /vagrant/id_rsa.pub >> /home/vagrant/.ssh/authorized_keys
touch /home/vagrant/.ssh/known_hosts
chmod 700 /home/vagrant/.ssh
chmod 600 /home/vagrant/.ssh/id_rsa
chmod 600 /home/vagrant/.ssh/known_hosts
chown vagrant /home/vagrant/.ssh/id_rsa
chown vagrant /home/vagrant/.ssh/known_hosts

echo "Updating apt"
sudo apt-get update

echo "Installing Apache2"

sudo apt-get -y install apache2
mkdir -p /var/www/html
chmod 0777 /var/www/
sudo chown vagrant:vagrant /var/www/
sudo chown vagrant:vagrant /var/www/html

sudo a2enmod rewrite
sudo a2enmod vhost_alias
echo "
<Directory '/var/www/html/'>
  Options Indexes FollowSymLinks MultiViews
  AllowOverride All
  Order allow,deny
  allow from all
</Directory>

<Virtualhost *:80>
    ServerAdmin webmaster@localhost
    VirtualDocumentRoot "/var/www/html/%0/public"
    ServerName server.dev
    ServerAlias *
    UseCanonicalName Off
    LogLevel warn
    ErrorLog /var/log/apache2/error.log
    CustomLog /var/log/apache2/access.log combined
</Virtualhost>
" > /etc/apache2/sites-available/server.conf

echo "ServerName server.dev" >> /etc/apache2/apache2.conf

sudo a2ensite server.conf 

sudo service apache2 restart

echo "Installing MySQL"

export DEBIAN_FRONTEND=noninteractive
apt-get -q -y install mysql-server-5.6 mysql-client-5.6
sudo sed -i "s/bind-address.*/bind-address = 0.0.0.0/" /etc/mysql/my.cnf
mysqladmin -u root password toor
sudo mysql -uroot -ptoor --execute "CREATE USER 'root'@'%' IDENTIFIED BY 'toor';"
sudo mysql -uroot -ptoor --execute "GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY 'toor' with GRANT OPTION; FLUSH PRIVILEGES;"
sudo service mysql stop
sudo service mysql start

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

echo "Installing git"

apt-get -y install git

git config --global user.email "$(awk -F "=" '/author.email/ {print $2}' /vagrant/user.ini)"
git config --global user.name "$(awk -F "=" '/author.name/ {print $2}' /vagrant/user.ini)"
git config --global push.default simple

echo "Installing Composer"
curl -sS https://getcomposer.org/installer | php
mv composer.phar /usr/local/bin/composer

echo "Install phing-build"

chown -R vagrant /opt/

sudo -u vagrant -H sh -c "ssh -o \"StrictHostKeyChecking no\" git@bitbucket.org"
sudo -u vagrant -H sh -c "ssh -o \"StrictHostKeyChecking no\" git@github.com"
sudo -u vagrant -H sh -c "cd /opt/ && git clone git@github.com:kirchbergerknorr/phing-build.git phing-build"
sudo -u vagrant -H sh -c "cd /opt/phing-build && git checkout 2.0.x"
sudo -u vagrant -H sh -c "cd /opt/phing-build && composer install"

curl -o n98-magerun.phar https://raw.githubusercontent.com/netz98/n98-magerun/master/n98-magerun.phar
sudo mv n98-magerun.phar /usr/bin/n98
sudo chmod 777 /usr/bin/n98

echo "
export PS1='\[\e[0;31m\]\u\[\e[m\] \[\e[1;34m\]\w\[\e[m\] \[\e[0;31m\]\D{%F %T}\n$ \[\e[m\]\[\e[0;32m\]'

alias a='sudo service apache2 restart'
alias p='/opt/phing-build/vendor/bin/phing -Dmake=/opt/phing-build/build.xml -Ddefaults=/vagrant/user.ini'
alias pl='/opt/phing-build/vendor/bin/phing -Ddefaults=/vagrant/user.ini -f /opt/phing-build/build.xml'
alias l='tail -F /var/log/apache2/error.log public/var/log/*'
alias w='cd /var/www/html/'
alias r='rm -rf public/var/cache/'
alias m='/vagrant/tools/pdo-enable-log.sh && tail -F public/var/debug/pdo_mysql.log'

alias b='source ~/.bash_profile;vim ~/.bash_profile'

alias gs='git status -uno'
alias gc='git commit -am '
alias ga='git add '

" > /home/vagrant/.bash_profile

echo "Istalling CasperJS"

sudo apt-get -y install nodejs-legacy nodejs npm
sudo npm install -g phantomjs
sudo npm install -g casperjs

echo "vagrant-box is ready"