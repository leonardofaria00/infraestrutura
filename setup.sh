#!/bin/bash
###################################################################################
# MANUAL DO DESENVOLVEDOR                                                         #
# Script que instala as principais ferramentas de Desenvolvimento web.            #
# DEVELOPER BY LEONARDO FARIA                                                     #
# (61) 9 91728815                                                                 #
# leonardofaria00@gmail.com                                                       #
#                                                                                 #
# Programas a serem instalados: JDK8, Apache2, PHP 7.3, Docker-ce, Kubernetes     #
# docker-compose, composer, Git, Filezilla, Mysql-serve, Workbench, SQL Developer #
# Google Chrome, NetBeans e outros programas                                      #
#                                                                                 #
# Version: 0.0.1                                                                  #
#                                                                                 #
###################################################################################

# Verificando versão do Sistema Operacional.
echo ''
echo '###### Sistema Operacional !######'
echo ''
lsb_release -a
sleep 10s

# Atualizando a máquina.
sudo apt-get update

# Instalando Outros Programas
echo ''
echo '###### Instalando Ferramentas úteis !######'
echo ''
sudo apt install -y vim curl

# Colorindo terminal
sudo cp /etc/skel/.bashrc /home/$USER/
sudo echo 'set number' >> /home/$USER/.vimrc
sudo echo 'syntax enable' >> /home/$USER/.vimrc
sudo echo 'force_color_prompt=yes' >> /home/$USER/.bashrc

# Instalando JDK
echo ''
echo '###### Instalado JDK8 !######'
echo ''
# sudo apt install software-properties-common
# sudo add-apt-repository ppa:linuxuprising/java
# sudo apt-get install -y openjdk-8-jdk

sudo apt-get install -y default-jdk
sudo update-alternatives --config java
# Definindo Variáveis de ambiente
# sudo vim .bashrc
sudo echo 'JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64/jre/bin/java' >> /home/$USER/.bashrc
sudo echo 'export JAVA_HOME' >> /home/$USER/.bashrc
sudo echo 'export PATH=$PATH:$JAVA_HOME' >> /home/$USER/.bashrc
echo $JAVA_HOME

javac -version
echo ''
echo '######JDK8 instalado com sucesso!######'
echo ''
sleep 5s

# Instalando NPM, Nodejs e Angular/CLI
# Referência: https://github.com/nodesource/distributions/blob/master/README.md#debinstall
echo ''
echo '###### Instalando Nodejs e Angular/CLI !######'
echo ''
sudo apt-get install -y npm
npm -v
# Using Ubuntu
curl -sL https://deb.nodesource.com/setup_14.x | sudo -E bash -
sudo apt-get install -y nodejs
node -v
sudo npm install -g @angular/cli
ng --version

# Instalando o apache2
echo ''
echo '###### Instalado Apache2 !######'
echo ''
sudo apt-get install -y apache2
sudo chown $USER:$USER /var/www/ -R
sudo service apache2 start
sudo systemctl status apache2
echo ''
echo '######Apache2 instalado com sucesso!######'
echo ''
sleep 5s

# Instalando o PHP
echo ''
echo '###### Instalado PHP !######'
echo ''
sudo apt-get install software-properties-common
sudo add-apt-repository ppa:ondrej/php
sudo apt-get update
sudo apt install -y php7.4 php-apcu php-cas php-bz2 php-zip php-xsl php-xmlrpc php-xml php-opcache php-mysql php-mbstring php-ldap php-json php-imap php-gd php-dev php-curl php-common php-cli php-bcmath
#sudo apt install -y php7.3 php-pear libapache2-mod-php7.3 php-common php7.3-cli php7.3-common php7.3-json php7.3-opcache php7.3-readline php7.3-zip php7.3-xsl php7.3-xmlrpc php7.3-xml php7.3-tidy php7.3-sybase php7.3-soap php7.3-mysql php7.3-mbstring php7.3-ldap php7.3-intl php7.3-imap php7.3-gd php7.3-dev php7.3-curl php7.3-cli php7.3-bcmath
sudo systemctl restart apache2
php -v
echo ''
echo '######PHP instalado com sucesso!######'
echo ''
sleep 5s
sudo apt -y autoremove

# Instalando o Git.
echo ''
echo '###### Instalado Git !######'
echo ''
sudo apt-get install -y git-all
sudo groupadd git
sudo usermod -aG git $USER
sudo git config --global http.sslVerify false
git --version # 2.25.1 today
echo ''
echo '######GitHub instalado com sucesso!######'
echo ''
sleep 5s

# Instalando o Docker.
echo ''
echo '###### Instalado Docker !######'
echo ''
sudo apt-get remove docker docker-engine docker.io containerd runc
sudo rm -rf /var/lib/docker
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt-get install -y apt-transport-https ca-certificates curl gnupg-agent software-properties-common
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo apt-get install -y docker-ce docker-ce-cli containerd.io
sudo groupadd docker
sudo usermod -aG docker $USER
sudo systemctl enable docker
sudo systemctl restart docker.service
sudo chown "$USER":"$USER" /home/"$USER"/.docker -R
sudo chown "$USER":"$USER" /var/run/docker.sock -R
sudo chmod g+rwx "$HOME/.docker" -R
docker run hello-world
#sudo chmod 777 -R /var/run/docker.sock
#sudo chmod 777 -R /home/users/.docker/
sudo docker version
echo ''
echo '######Docker instalado com sucesso!######'
echo ''
sleep 5s

# Instalando o Docker-compose.
echo ''
echo '###### Instalado Docker-compose !######'
echo ''
sudo curl -L "https://github.com/docker/compose/releases/download/1.26.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose
docker-compose --version
echo ''
echo '######Docker-compose instalado com sucesso!######'
echo ''
sleep 5s

# Instalando o Composer.
echo ''
echo '###### Instalado Composer !######'
echo ''
sudo apt-get install -y composer
composer --version
echo ''
echo '######Composer instalado com sucesso!######'
echo ''
sleep 5s

# Instalando o MySQL
echo ''
echo '######Instalando MySQL!######'
sudo apt-get -y remove mysql-server
sudo apt-get install -y mysql-server
sudo service mysql restart
# sudo mysql_secure_installation
# sudo mysql -u root
# SELECT user FROM mysql.user;
# CREATE USER 'leonardo'@'localhost' IDENTIFIED BY '@#Password123';
# GRANT ALL ON *.* TO 'leonardo'@'localhost';
# FLUSH PRIVILEGES;
# quit;
sudo service mysql status
echo ''
echo '######MySQL instalado com sucesso!######'
echo ''
sleep 5s

# Instalando o WorkBench
echo ''
echo '###### Instalado WorkBench !######'
echo ''
sudo apt install -y libpcrecpp0v5 libpython2.7 libzip5 libpython2.7-stdlib libpython2.7-minimal
sudo apt install -y mysql-workbench
sleep 5s

# Instalando o SQLDeveloper
# echo ''; echo '###### Instalado SQL Developer !######'; echo '';
# https://askubuntu.com/questions/458554/how-to-install-sql-developer-on-ubuntu-14-04
# sudo apt-get install -y sqldeveloper-package
# echo ''; echo '######SQLDeveloper instalado com sucesso!######'; echo '';
# sleep 5s

# Fazendo o upgrade, limpando cache e reiniciando a máquina.
echo ''
echo '######Limpando caches!######'
echo ''
sudo apt -y autoremove
sudo apt autoclean
sudo apt remove
sudo apt clean
sudo rm -rf /var/lib/apt/lists/*
sudo rm -rf /var/tmp/*
echo ''
echo 'INSTALAÇÕES FINALIZADAS COM SUCESSO!'
echo ''
sleep 10s
clear
echo 'A Máquina será reiniciada em 30 segundos!'
sleep 30s
sudo init 6
