
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

TODO:
Application Needs (in order of importance):
* Time delay in sessions
* Fix show tiles: arrangement, display for both searches and recommends
* Build My Searches section
* Login Functionality 

From code:
/home/tauhir/SeriesRecommender/app/models/search.rb
  line 5    TODO  need to update this to be able to search next page and add to list. might need to add current page attrib?
  line 19   TODO  can probably remove search_id param then use self.id
  line 112  TODO  no results

/home/tauhir/SeriesRecommender/app/frontend/packs/application.js
  line 133  TODO  check to see if no search options left and let user know
  line 163  TODO  , why is window constantly needed? See this as starting point
  
