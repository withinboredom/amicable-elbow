#!/usr/bin/env bash

DEBIAN_FRONTEND=noninteractive

echo "Updating server"
apt-get update
apt-get install -y aptitude
aptitude hold grub-common grub-pc grub-pc-bin grub2-common linux-firmware busybox-initramfs
aptitude -y safe-upgrade

echo "Installing packages"
sudo debconf-set-selections <<< 'mysql-server-5.5 mysql-server/root_password password root'
sudo debconf-set-selections <<< 'mysql-server-5.5 mysql-server/root_password_again password root'
sudo apt-get -y install mysql-server-5.5 php5-mysql libsqlite3-dev apache2 php5 php5-dev build-essential php-pear git ruby rubygems sshpass

# Set timezone
echo "America/New_York" | sudo tee /etc/timezone
sudo dpkg-reconfigure --frontend noninteractive tzdata

# Setup database
if [ ! -f /var/log/databasesetup ];
then
    echo "Setting up the database"
    echo "DROP DATABASE IF EXISTS test" | mysql -uroot -proot
    echo "CREATE USER 'devdb'@'localhost' IDENTIFIED BY 'devdb'" | mysql -uroot -proot
    echo "CREATE DATABASE devdb" | mysql -uroot -proot
    echo "GRANT ALL ON devdb.* TO 'devdb'@'localhost'" | mysql -uroot -proot
    echo "flush privileges" | mysql -uroot -proot

    sudo touch /var/log/databasesetup
    echo "Database setup complete"

    if [ -f /vagrant/sqldump/database.sql ];
    then
        echo "Importing database"
        mysql -uroot -proot devdb < /vagrant/sqldump/database.sql
        echo "Database import complete"
    fi
fi

# Load Database
if [ ! -f /var/log/loaddatabase ];
then
  if [ -f /vagrant/sqldump/database.sql ];
  then
    echo "Importing database"
    mysql -uroot -proot devdb < /vagrant/sqldump/database.sql
    echo "Database import complete"
  fi
  sudo touch /var/log/loaddatabase
fi

# Apache changes
if [ ! -f /var/log/webserversetup ];
then
    echo "Enabling mod rewrite"
    sudo a2enmod rewrite
    sudo sed -i '/AllowOverride None/c AllowOverride All' /etc/apache2/sites-available/default

    echo "Mod rewrite enabled"
    sudo touch /var/log/webserversetup
fi

# Install Mailcatcher
if [ ! -f /var/log/mailcatchersetup ];
then
    echo "Installing mailcatcher"
    sudo gem install mailcatcher

    echo "Mail catcher installed"
    sudo touch /var/log/mailcatchersetup
fi

# Install xdebug
if [ ! -f /var/log/xdebugsetup ];
then
    echo "Installing xdebug"
    sudo pecl install xdebug
    XDEBUG_LOCATION=$(find / -name 'xdebug.so' 2> /dev/null)

    echo "xdebug installed"
    sudo touch /var/log/xdebugsetup
fi

# Configure PHP
if [ ! -f /var/log/phpsetup ];
then
    echo "Configuring PHP"
    sudo sed -i '/;sendmail_path =/c sendmail_path = "/opt/vagrant_ruby/bin/catchmail"' /etc/php5/apache2/php.ini
    sudo sed -i '/display_errors = Off/c display_errors = On' /etc/php5/apache2/php.ini
    sudo sed -i '/error_reporting = E_ALL & ~E_DEPRECATED/c error_reporting = E_ALL | E_STRICT' /etc/php5/apache2/php.ini
    sudo sed -i '/html_errors = Off/c html_errors = On' /etc/php5/apache2/php.ini
    echo "zend_extension='$XDEBUG_LOCATION'" | sudo tee -a /etc/php5/apache2/php.ini > /dev/null

    echo "PHP.ini configured"
    sudo touch /var/log/phpsetup
fi

echo "Linking web root to vagrant root"
rm -rf /var/www
ln -fs /vagrant/src /var/www

# Make sure things are up and running as they shoulxd be
mailcatcher --http-ip=192.168.137.139

cd /vagrant
php composer.phar self-update
php composer.phar install
php composer.phar update

rm -rf /vagrant/src/js/libs/components
cp /vagrant/components /vagrant/src/js/libs -r

cp /vagrant/vendor/kalenjordan/jquery-cookie/jquery.cookie.js /vagrant/src/js/libs/components

sudo service apache2 restart
echo "All done!"