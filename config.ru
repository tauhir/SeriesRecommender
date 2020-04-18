# This file is used by Rack-based servers to start the application.

require_relative 'config/environment'
require 'Popular.rb'
Search.create({:current_query => "popular page"}) if Search.all.empty?
Popular.new.get_10_popular_pages()
run Rails.application
