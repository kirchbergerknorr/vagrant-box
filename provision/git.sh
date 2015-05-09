echo "Installing git"

apt-get -y install git

git config --global user.email "$(awk -F "=" '/author.email/ {print $2}' /vagrant/user.ini)"
git config --global user.name "$(awk -F "=" '/author.name/ {print $2}' /vagrant/user.ini)"
git config --global push.default simple
