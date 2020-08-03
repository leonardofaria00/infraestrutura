#!/bin/bash
###################################################################################
# MANUAL DO DESENVOLVEDOR                                                         #
# Script que instala as principais ferramentas de Desenvolvimento web.            #
# DEVELOPER BY LEONARDO SANTOS                                                    #
#                                                                                 #
# Programas a serem instalados: JDK8, Apache2, PHP 7.4, Docker                    #
# docker-compose, composer, Git, Mysql-serve e outros programas                   #
#                                                                                 #
# Version: 1.0.1                                                                  #
#                                                                                 #
###################################################################################

getOS() {
    echo ''
    echo '###### Sistema Operacional !######'
    lsb_release -a
    sleep 5s
}

getUpdate() {
    echo ''
    echo 'Atualizando a máquina...'
    sleep 2s
    sudo apt -y update && sudo apt -y upgrade
}

getUtil() {
    echo ''
    echo 'Instalando programas úteis...'
    sleep 2s
    sudo apt install -y vim curl wget psensor gsmartcontrol gnome-tweaks
}

getColor() {
    echo 'Colorindo terminal...'
    sleep 2s
    sudo cp /etc/skel/.bashrc /home/$USER/
    sudo echo 'set number' >>/home/$USER/.vimrc
    sudo echo 'syntax enable' >>/home/$USER/.vimrc
    sudo echo 'force_color_prompt=yes' >>/home/$USER/.bashrc
}

getJDK() {
    echo ''
    echo 'Instalado JDK8...'
    sleep 2s
    sudo apt install -y software-properties-common
    sudo add-apt-repository ppa:linuxuprising/java
    sudo apt install -y openjdk-8-jdk

    sudo echo 'JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64/jre/bin/java' >>/home/$USER/.bashrc
    sudo echo 'export JAVA_HOME' >>/home/$USER/.bashrc
    sudo echo 'export PATH=$PATH:$JAVA_HOME' >>/home/$USER/.bashrc
    source .bashrc
    echo $JAVA_HOME

    javac -version
    sleep 5s
    # sudo apt-get install -y default-jdk
    # sudo update-alternatives --config java
    # Definindo Variáveis de ambiente
}

getAngular() {
    echo ''
    echo 'Instalando NPM, Nodejs e Angular/CLI...'
    sleep 2s
    # Referência: https://github.com/nodesource/distributions/blob/master/README.md#debinstall
    sudo apt install -y npm
    npm -v

    curl -sL https://deb.nodesource.com/setup_14.x | sudo -E bash -
    sudo apt install -y nodejs
    node -v
    sudo npm install -g @angular/cli
    ng --version
}

getApache() {
    echo ''
    echo 'Instalado Apache2...'
    sleep 2s
    sudo apt install -y apache2
    sudo chown $USER:$USER /var/www/ -R
    sudo service apache2 start
    sudo systemctl status apache2
    sleep 5s
}

getClean() {
    echo ''
    echo 'Limpando caches...'
    sleep 2s
    sudo apt -y autoremove
    sudo apt autoclean
    sudo apt remove
    sudo apt clean
    sudo rm -rf /var/lib/apt/lists/*
    sudo rm -rf /var/tmp/*
    echo ''
    echo 'Tudo limpo!'
    sleep 2s
    clear
}

getPHP() {
    echo ''
    echo 'Instalado PHP...'
    sleep 2s
    sudo apt install software-properties-common
    sudo add-apt-repository ppa:ondrej/php
    sudo apt update
    sudo apt install -y php7.4 php-apcu php-cas php-bz2 php-zip php-xmlrpc php-xml php-mysql php-mbstring php-ldap php-json php-imap php-gd php-dev php-curl php-common php-cli php-bcmath
    sudo systemctl restart apache2
    php -v
    sleep 5s
    getClean
}

getGit() {
    echo ''
    echo 'Instalado Git...'
    sleep 2s
    sudo apt install -y git-all
    sudo groupadd git
    sudo usermod -aG git $USER
    sudo git config --global http.sslVerify false
    echo git config --global user.name "leonardofaria00"
    echo git config --global user.email "leonardofaria00@gmail.com"
    git --version
    sleep 5s
}

getDocker() {
    echo ''
    echo 'Instalado Docker...'
    sleep 2s
    sudo apt remove docker docker-engine docker.io containerd runc
    sudo rm -rf /var/lib/docker
    getClean
    sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
    sudo apt install -y apt-transport-https ca-certificates curl gnupg-agent software-properties-common
    sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
    getUpdate
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
    docker version
    sleep 5s
}

getDockerComposer() {
    echo ''
    echo 'Instalado Docker-compose...'
    sleep 2s
    sudo curl -L "https://github.com/docker/compose/releases/download/1.26.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
    sudo chmod +x /usr/local/bin/docker-compose
    sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose
    docker-compose --version
    sleep 5s
}

getComposer() {
    echo ''
    echo 'Instalado Composer...'
    sleep 2s
    sudo apt install -y composer
    composer --version
    sleep 5s
}

getMySQL() {
    echo ''
    echo 'Instalando MySQL...'
    sudo apt -y remove mysql-server
    sudo apt install -y mysql-server
    sudo service mysql restart
    sudo service mysql status
    sleep 5s
    # sudo mysql_secure_installation
    # sudo mysql -u root
    # SELECT user FROM mysql.user;
    # CREATE USER 'leonardo'@'localhost' IDENTIFIED BY '@#Password123';
    # GRANT ALL ON *.* TO 'leonardo'@'localhost';
    # FLUSH PRIVILEGES;
    # quit;
}

getWine(){
    sudo dpkg --add-architecture i386 
    wget -O - https://dl.winehq.org/wine-builds/winehq.key | sudo apt-key add -
    sudo add-apt-repository 'deb https://dl.winehq.org/wine-builds/ubuntu/ focal main'
    sudo apt update
    sudo apt -y install --install-recommends winehq-stable
    winecfg
}

getVSCode(){
cp -v settings.json ~/.config/Code/User/
}
# Limpando caches e reiniciando a máquina

restart() {
    echo 'A Máquina será reiniciada em 10 segundos...'
    sleep 10s
    sudo init 6
}

getOS
getUpdate
getUtil
getColor
getJDK
# getAngular
# getApache
# getPHP
getGit
getDocker
getDockerComposer
# getComposer
# getMySQL
getWine
getVSCode
getClean
restart
