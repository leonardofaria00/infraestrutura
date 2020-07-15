#!/bin/bash
###################################################################################
# MANUAL DO DESENVOLVEDOR                                                         #
# Script que instala as principais ferramentas de Desenvolvimento web.            #
# DEVELOPER BY LEONARDO SANTOS                                                    #
# (61) 9 91728815                                                                 #
# leonardofaria00@gmail.com                                                       #
#                                                                                 #
# Programas a serem instalados: JDK8, Apache2, PHP 7.3, Docker-ce, Kubernetes     #
# docker-compose, composer, Git, Filezilla, Mysql-serve, Workbench, SQL Developer #
# Google Chrome, NetBeans e outros programas                                      #
#                                                                                 #
# Version: 1.0.1                                                                  #
#                                                                                 #
###################################################################################

# Verificando versão do Sistema Operacional.
echo ''
echo '###### Sistema Operacional !######'
echo ''
lsb_release -a
sleep 10s

limpar (){
echo ''
echo '###### Limpando caches! ######'
echo ''
sudo apt -y autoremove
sudo apt autoclean
sudo apt remove
sudo apt clean
sudo rm -rf /var/lib/apt/lists/*
sudo rm -rf /var/tmp/*
echo ''
echo 'Tudo limpo!'
echo ''
sleep 2s
clear
}

# Atualizando a máquina.
sudo apt -y update && apt -y upgrade

echo ''
echo '###### Instalando programas úteis !######'
echo ''
sudo apt install -y vim curl psensor gsmartcontrol gnome-tweaks

# Colorindo terminal
sudo cp /etc/skel/.bashrc /home/$USER/
sudo echo 'set number' >> /home/$USER/.vimrc
sudo echo 'syntax enable' >> /home/$USER/.vimrc
sudo echo 'force_color_prompt=yes' >> /home/$USER/.bashrc

echo ''
echo '###### Instalado JDK8 !######'
echo ''
sudo apt install -y software-properties-common
sudo add-apt-repository ppa:linuxuprising/java
sudo apt install -y openjdk-8-jdk

# sudo apt-get install -y default-jdk
# sudo update-alternatives --config java
# Definindo Variáveis de ambiente
sudo echo 'JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64/jre/bin/java' >> /home/$USER/.bashrc
sudo echo 'export JAVA_HOME' >> /home/$USER/.bashrc
sudo echo 'export PATH=$PATH:$JAVA_HOME' >> /home/$USER/.bashrc
echo $JAVA_HOME

javac -version
sleep 5s

echo ''
echo '###### Instalando NPM, Nodejs e Angular/CLI !######'
echo ''
# Referência: https://github.com/nodesource/distributions/blob/master/README.md#debinstall
sudo apt install -y npm
npm -v
# Using Ubuntu
curl -sL https://deb.nodesource.com/setup_14.x | sudo -E bash -
sudo apt install -y nodejs
node -v
sudo npm install -g @angular/cli
ng --version

echo ''
echo '###### Instalado Apache2 !######'
echo ''
sudo apt install -y apache2
sudo chown $USER:$USER /var/www/ -R
sudo service apache2 start
sudo systemctl status apache2
sleep 5s

echo ''
echo '###### Instalado PHP !######'
echo ''
sudo apt install software-properties-common
sudo add-apt-repository ppa:ondrej/php
sudo apt update
sudo apt install -y php7.4 php-apcu php-cas php-bz2 php-zip php-xmlrpc php-xml php-mysql php-mbstring php-ldap php-json php-imap php-gd php-dev php-curl php-common php-cli php-bcmath
sudo systemctl restart apache2
php -v
sleep 5s
limpar

echo ''
echo '###### Instalado Git !######'
echo ''
sudo apt install -y git-all
sudo groupadd git
sudo usermod -aG git $USER
sudo git config --global http.sslVerify false
git --version
sleep 5s

echo ''
echo '###### Instalado Docker !######'
echo ''
sudo apt remove docker docker-engine docker.io containerd runc
sudo rm -rf /var/lib/docker
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt install -y apt-transport-https ca-certificates curl gnupg-agent software-properties-common
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo apt install -y docker-ce docker-ce-cli containerd.io
sudo groupadd docker
sudo usermod -aG docker $USER
sudo systemctl enable docker
sudo systemctl restart docker.service
sudo chown "$USER":"$USER" /home/"$USER"/.docker -R
sudo chown "$USER":"$USER" /var/run/docker.sock -R
sudo chmod g+rwx "$HOME/.docker" -R
docker run hello-world
# sudo chmod 777 -R /var/run/docker.sock
# sudo chmod 777 -R /home/users/.docker/
sudo docker version
sleep 5s

echo ''
echo '###### Instalado Docker-compose !######'
echo ''
sudo curl -L "https://github.com/docker/compose/releases/download/1.26.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose
docker-compose --version
echo ''
echo '######Docker-compose instalado com sucesso!######'
echo ''
sleep 5s

echo ''
echo '###### Instalado Composer !######'
echo ''
sudo apt install -y composer
composer --version
sleep 5s

echo ''
echo '######Instalando MySQL!######'
sudo apt -y remove mysql-server
sudo apt install -y mysql-server
sudo service mysql restart
# sudo mysql_secure_installation
# sudo mysql -u root
# SELECT user FROM mysql.user;
# CREATE USER 'leonardo'@'localhost' IDENTIFIED BY '@#Password123';
# GRANT ALL ON *.* TO 'leonardo'@'localhost';
# FLUSH PRIVILEGES;
# quit;
sudo service mysql status
sleep 5s

echo ''
echo '###### Instalado WorkBench !######'
echo ''
sudo apt install -y libpcrecpp0v5 libpython2.7 libzip5 libpython2.7-stdlib libpython2.7-minimal
sudo apt install -y mysql-workbench
sleep 5s

# Limpando caches e reiniciando a máquina
limpar

echo 'A Máquina será reiniciada em 10 segundos!'
sleep 10s
sudo init 6