#!/usr/bin/env bash
set -i

sudo apt-get -y install git curl g++ make
sudo apt-get -y install zlib1g-dev libssl-dev libreadline-dev
sudo apt-get -y install libyaml-dev libxml2-dev libxslt-dev
sudo apt-get -y install sqlite3 libsqlite3-dev nodejs

git clone git://github.com/sstephenson/rbenv.git ~/.rbenv
git clone https://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build
echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
echo 'eval "$(rbenv init -)"' >> ~/.bashrc

source ~/.bashrc

rbenv install 2.4.0
rbenv rehash
rbenv global 2.4.0

gem update --system
gem install bundler
gem install rails --version='5.1.4'
gem install sqlite3
gem install therubyracer

cd /vagrant

bundle install --without production
