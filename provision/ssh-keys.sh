echo "Configuring SSH"

cp /vagrant/id_rsa /home/vagrant/.ssh/id_rsa
cat /vagrant/id_rsa.pub >> /home/vagrant/.ssh/authorized_keys
touch /home/vagrant/.ssh/known_hosts
chmod 700 /home/vagrant/.ssh
chmod 600 /home/vagrant/.ssh/id_rsa
chmod 600 /home/vagrant/.ssh/known_hosts
chown vagrant /home/vagrant/.ssh/id_rsa
chown vagrant /home/vagrant/.ssh/known_hosts
