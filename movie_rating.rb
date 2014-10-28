require "pry"
require "csv"
require "rest_client"
require "json"

movies_years = CSV.read("short_movies.csv")
movies_ratings = {}

movies_years.each do |movie|
  url = URI.encode("http://www.omdbapi.com/?t=#{ movie[0].split(" ").join("+") }&y=#{ movie[1] }")
  response = JSON.parse(RestClient.get(url))

  if response["imdbRating"] && response["imdbRating"] != "N/A"
    movies_ratings[movie[0]] = response["imdbRating"].to_f
  else
    movies_ratings[movie[0]] = -1
  end
end

CSV.open("movies_with_ratings.csv", "w") do |csv|
  movies_ratings.sort_by{ |_k, v| -v }.each do |movie|
    movie[1] = "N/A" if movie[1] == -1

    puts "#{ movie[0] } -- #{ movie[1] }"
    csv << [movie[0], movie[1]]
  end
end
