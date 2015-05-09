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
