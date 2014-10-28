require "pry"
require "csv"
require "rest_client"
require "json"

movies_years = CSV.read("movies.csv")
movies_ratings = []

movies_years.each do |movie|
  movies_ratings << RestClient.get("http://www.omdbapi.com/?t=#{movie[0].split(" ").join("+")}&y=#{movie[1]}")
  binding.pry
end

