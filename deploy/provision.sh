#!/bin/sh

#usage provision.sh GITUSER GITREPO 
#                     $1       $2

#cp /var/www/appti2ude/vendor/kalenjordan/jquery-cookie/jquery.cookie.js /var/www/appti2ude/components/

rm -rf /var/www/appti2ude
git clone https://github.com/$1/$2.git /var/www/appti2ude

cd /var/www/appti2ude

php /var/www/appti2ude/composer.phar selfupdate
php /var/www/appti2ude/composer.phar install
php /var/www/appti2ude/composer.phar update