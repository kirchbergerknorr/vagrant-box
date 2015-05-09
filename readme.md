# vagrant-box

Utilizes Ubuntu 14.04

## Pre requisites

1. Install [VirtualBox](https://www.virtualbox.org/)
2. Install [Vagrant](https://www.vagrantup.com/)

## Installation

1. Clone the Repository

        git clone https://github.com/kirchbergerknorr/vagrant-box.git

2. Navigate to the folder

        cd vagrant-box 

3. Copy your private and public key to directory

        cp ~/.ssh/id_rsa ./
        cp ~/.ssh/id_rsa.pub ./
 
4. Configure variables

        cp user.ini.template user.ini

5. Run Vagrant Command
 
        vagrant up
    
## Additional Plugins 

- Port forwarding for MacOS:

        echo "
        rdr pass on lo0 inet proto tcp from any to 127.0.0.1 port 80 -> 127.0.0.1 port 8080
        rdr pass on lo0 inet proto tcp from any to 127.0.0.1 port 443 -> 127.0.0.1 port 8443
        " | sudo pfctl -f - > /dev/null 2>&1; echo "==> Fowarding Ports: 80 -> 8080, 443 -> 8443"

- Install simple DNS Server for MacOS to forward *.dev to 127.0.0.1
  
## Credentials

    SSH Username: vagrant
    SSH Password: vagrant
    Database Username: root
    Database Password: toor
    URL of Instance: http://your-project.dev/ 

## Usage

    vagrant ssh

## XDebug

Use [XDebug bookmarklets generator for PhpStorm](https://www.jetbrains.com/phpstorm/marklets/).

## Support
 
If you have any issues with this extension, open an issue on [GitHub](https://github.com/kirchbergerknorr/vagrant-box/issues).

## Contribution

Any contribution is highly appreciated. The best way to contribute code is to open a [pull request on GitHub](https://help.github.com/articles/using-pull-requests).

## License

[OSL - Open Software Licence 3.0](http://opensource.org/licenses/osl-3.0.php) 