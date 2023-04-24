#!/bin/bash

cd /home/vagrant
wget https://ftp.postgresql.org/pub/source/v8.4.22/postgresql-8.4.22.tar.gz --no-check-certificate
tar -xnf postgresql-8.4.22.tar.gz
wget https://archives.fedoraproject.org/pub/archive/epel/6/x86_64/epel-release-6-8.noarch.rpm
sudo yum localinstall epel-release-6-8.noarch.rpm
sudo yum update -y
wget ftp://ftp.pbone.net/mirror/vault.centos.org/6.8/os/x86_64/Packages/readline-devel-6.0-4.el6.x86_64.rpm --no-check-certificate
sudo yum localinstall readline-devel-6.0-4.el6.x86_64.rpm -y
sudo yum install ncurses-devel -y
#sudo yum install readline-devel -y
sudo yum install bison -y
sudo yum install zlib-devel -y
sudo chown vagrant:whel postgresql-8.4.22
sudo chmod 0777 postgresql-8.4.22
cd  postgresql-8.4.22
./configure --enable-depend
gmake
sudo gmake install
sudo LD_LIBRARY_PATH=/usr/local/pgsql/lib && export LD_LIBRARY_PATH
sudo PATH=/usr/local/pgsql/bin:$PATH && export PATH
sudo groupadd postgres
sudo useradd -g postgres postgres
sudo usermod -aG postgres postgres
sudo mkdir /var/log/pgsql
sudo chown postgres:postgres /var/log/pgsql
sudo chmod 0700 /var/log/pgsql
sudo mkdir /usr/local/pgsql/data
sudo chown postgres:postgres /usr/local/pgsql/data
sudo chmod 0700 /usr/local/pgsql/data
su -c "/usr/local/pgsql/bin/initdb -D /usr/local/pgsql/data" postgres
su -c '/usr/local/pgsql/bin/pg_ctl start -l /usr/local/pgsql/data/log/logfile -D /usr/local/pgsql/data' postgres
echo "su -c '/usr/bin/pg_ctl start -l /usr/local/pgsql/data/log/logfile -D /usr/local/pgsql/data' postgres" >> /etc/rc.local