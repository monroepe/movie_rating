require "pry"
require "csv"
require "rest_client"
require "json"

movies_years = CSV.read("short_movies.csv")
movies_ratings = {}

movies_years.each do |movie|
  movies_ratings[movie[0]] = JSON.parse(RestClient.get("http://www.omdbapi.com/?t=#{movie[0].split(" ").join("+")}&y=#{movie[1]}"))["imdbRating"].to_f
end

CSV.open("movies_with_ratings.csv", "w") do |csv|
  movies_ratings.sort_by{ |_k, v| -v }.each do |movie|
    puts "#{movie[0]} -- #{movie[1]}"
    csv << [movie[0], movie[1]]
  end
end
