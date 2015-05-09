# This script can be used to perform any sort of command line actions to setup your box.
# This includes installing software, importing databases, enabling new sites, pulling from
# remote servers, etc.

sudo sh /vagrant/provision/ssh-keys.sh
sudo sh /vagrant/provision/update.sh
sudo sh /vagrant/provision/apache2.sh
sudo sh /vagrant/provision/mysql.sh
sudo sh /vagrant/provision/php.sh
sudo sh /vagrant/provision/git.sh
sudo sh /vagrant/provision/composer.sh
sudo sh /vagrant/provision/phing-build.sh
sudo sh /vagrant/provision/casperjs.sh

echo "vagrant-box is ready"
