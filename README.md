# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies
Install:
install as per setup.sh
Rename '.envsample' to .env and add tmdb api key (https://github.com/bkeepers/dotenv)


* To Run
sudo -u postgres createuser --superuser <user> (creating role with my username here)
sudo pg_ctlcluster 10 main start - for some reason I have to do this on WSL 2.
rails db:migrate
foreman start


* Configuration
https://github.com/bkeepers/dotenv =env file
* Database creation

* Database initialization
sudo -u postgres createuser --superuser tauhir (username here)
rails db:migrate
* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...
