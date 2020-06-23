#!/bin/sh
apt-get update  # To get the latest package lists
apt-get install -y libreadline-dev zlib1g-dev build-essential npm
git clone https://github.com/rbenv/rbenv.git ~/.rbenv
echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
echo 'eval "$(rbenv init -)"' >> ~/.bashrc
exec $SHELL
git clone https://github.com/rbenv/ruby-build.git "$(rbenv root)"/plugins/ruby-build
rbenv install 2.7.0 #ruby 2.7.0
gem install bundler
rbenv rehash
gem install rails -v 6.0.2

#node 
sudo npm install -g n
sudo n stable
#yarn
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
sudo apt update && sudo apt install yarn
yarn install
gem install dotenv
bundle install
sudo pg_ctlcluster 10 main start
#etc.

