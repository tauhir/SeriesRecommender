
# README
# Series Recommender

A webapp using Ruby-on-rails to help determine television shows you might like! This webapp makes use of TMDB's API to get all shows and information.
Overview


# Features
This app allows you to search through a database of shows letting you like or dislike them. From the list, the system builds recommendations tailored to your likes. These lists can be shared with others. You can see where this show can be viewed in your region (MAJOR TODO)


# Running The Project
I've built a setup install file that can be used to setup all the dependencies. Clone the repo then run setup.sh
* Ruby version: 2.7.0
* Rails version: 6.0.2

* System dependencies

This application makes use of [Dotenv](https://github.com/bkeepers/dotenv). On setup, you need to rename '.envsample' to ".env" and add the required keys (TMDB API KEY) 


To Run
* Create your user role for the Postgres db:
> sudo -u postgres createuser --superuser <user> (creating role with my username here)
* Start the server:
> sudo pg_ctlcluster 10 main start - for some reason I have to do this on WSL 2.
* Migrate the server:
> rails db:migrate
* Start the application:
> foreman start
