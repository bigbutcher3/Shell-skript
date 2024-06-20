#!/bin/bash

menu() {
    clear
    echo "############################################"
    echo "--------------------Menu--------------------"
    echo "############################################"
    echo "Enter 1 Installation \"Update & Upgrade\""
    echo "Enter 2 Intstallation \"Net-Tools\""
    echo "Enter 3 Intstallation \"SSH\""
    echo "Enter 4 Intstallation \"Apache2\""
    echo "Enter 5 Intstallation \"PHP-Module\""
    echo "Enter 6 Intstallation \"Maria-DB\""
    echo "Enter 7 Intstallation \"PHPmyAdmin\""
    echo "Enter 8 Intstallation \"Composer\""
    echo "Enter 9 Intstallation \"Gastzugang\""
    echo "Enter q \"exit\""

    read wahl

    case $wahl in
        1) option1 ;;
        2) option2 ;;
        3) option3 ;;
        4) option4 ;;
        5) option5 ;;
        6) option6 ;;
        7) option7 ;;
        8) option8 ;;
        9) option9 ;;
        q) break ;;
        *) menu ;;
    esac
}

option1() {
    apt update
    apt upgrade -y
    read -p "Enter drücken, um zum Menü zurückzukehren..." x
    menu
}

option2() {
    ifconfig
    read -p "Enter drücken, um zum Menü zurückzukehren..." x
    menu
}

option3() {
    echo "UseDNS no" >> /etc/ssh/sshd_config
    echo "PermitRootLogin yes" >> /etc/ssh/sshd_config
    echo "SSHD_OPTS=\"-u0\"" > /etc/default/ssh
    systemctl restart ssh
    read -p "Enter drücken, um zum Menü zurückzukehren..." x
    menu
}

option4() {
    echo "<?php" > /var/www/html/phpinfo.php
    echo "  phpinfo();" >> /var/www/html/phpinfo.php
    echo "?>" >> /var/www/html/phpinfo.php
    echo "<VirtualHost *:80>" > /etc/apache2/sites-available/example.conf
    echo "  ServerName servername" >> /etc/apache2/sites-available/example.conf
    echo "  ServerAlias *.servername" >> /etc/apache2/sites-available/example.conf
    echo "  DocumentRoot \"/vagrant/public" >> /etc/apache2/sites-available/example.conf
    echo "  ServerAdmin admin@servername" >> /etc/apache2/sites-available/example.conf
    echo "  DirectoryIndex index.php index.html index.htm" >> /etc/apache2/sites-available/example.conf
    echo "  <Directory \"/vagrant/public\">" >> /etc/apache2/sites-available/example.conf
    echo "      Options +Indexes +FollowSymLinks +MultiViews" >> /etc/apache2/sites-available/example.conf
    echo "      AllowOverride All" >> /etc/apache2/sites-available/example.conf
    echo "      Require all granted" >> /etc/apache2/sites-available/example.conf
    echo "  </Directory>" >> /etc/apache2/sites-available/example.conf
    echo "</VirtualHost>" >> /etc/apache2/sites-available/example.conf
    systemctl restart apache2
    read -p "Enter drücken, um zum Menü zurückzukehren..." x
    menu
}

option5() {
    #zusätzliche PHP-Module
    #"i" -> installieren
    #"r" -> deinstallieren
    read -p "Enter drücken, um zum Menü zurückzukehren..." x
    menu
}

option6() {
    #user: 'root'@'%'
    #passwd: root
    read -p "Enter drücken, um zum Menü zurückzukehren..." x
    menu
}

option7() {
    curl -O https://files.phpmyadmin.net/phpMyAdmin/5.2.1/phpMyAdmin-5.2.1-all-languages.tar.gz
    tar xf phpMyAdmin-5.2.1-all-languages.tar.gz --directory=/var/www/html/
    rm -f phpMyAdmin-5.2.1-all-languages.tar.gz
    #"blowfish_secret" festlegen
    #"mysql|information_schema|performance_schema|phpmyadmin|sys" verstecken
    #Erstellen der Tabellen in der MySQL-Datenbank für phpMyAdmin
    #Setzen von Berechtigungen für das phpMyAdmin-Verzeichnis
    #   www-data:www-data
    #   755
    read -p "Enter drücken, um zum Menü zurückzukehren..." x
    menu
}

option8() {
    php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
    php -r "if (hash_file('sha384', 'composer-setup.php') === 'dac665fdc30fdd8ec78b38b9800061b4150413ff2e3b6f88543c636f7cd84f6db9189d43a81e5503cda447da73c7e5b6') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
    php composer-setup.php
    php -r "unlink('composer-setup.php');"
    mv composer.phar /usr/local/bin/composer
    read -p "Enter drücken, um zum Menü zurückzukehren..." x
    menu
}

option9() {
    echo "vagrant   ALL=(ALL:ALL) ALL" >> /etc/sudoers
    chown vagrant:vagrant /vagrant
    chmod 0777 /vagrant
    apt install linux-headers-$(uname -r) -y
    #Einbinden des CD-ROM-Laufwerks und Ausführen der VirtualBox Guest Additions-Installation
    systemctl status systemd-modules-load
    read -p "Enter drücken, um das System neuzustarten und die Änderungen wirksam werden zu lassen..." x
    reboot now
}

menu
