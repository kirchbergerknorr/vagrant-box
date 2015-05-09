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
