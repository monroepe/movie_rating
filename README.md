This is program that given a csv of movies and years finds the imdb rating and outputs the title and the movie in descending order (by rating). It also writes the results to a csv file.

In order to run the program you need the 'rest-client' gem (included in the gem file). This gem is used to get the data from the API. Other than that I included the CSV and JSON modules to read, parse, and write the data.

The program functions by simply reading in the data from the csv, making a call to the API for each movie, and outputting the title and rating, both to screen and a separate csv. To test with the different csv files, simply change line 6 of movie_rating.rb:

movies_years = CSV.read("movies.csv")

Change the "movies.csv" to the desired csv file.

The program is set up to use the entire csv, but I included another, smaller CSV for testing (as it takes awhile to run with over 1000 movies). During the development of the program I ran into several edge cases.

The first was the movie "Arthur Rubinstein – The Love of Life". At first this broke the program, because there is no such movie in the database with that exact title. I fixed that problem by encoding the url, so the program would not break and simply assign an "N/A" rating to the movie. However, this doesn't fully solve the problem because this movie does exist in the database with the title "Love of Life." This was not the only edge case I ran into where the title is incorrect. Another example is "E.T.: The Extra-Terrestrial." If you check, this movie has a 2.2 rating, which could be true, but is unlikely as the film was very good. The problem is that written this way, the database actually chooses the E.T. video game (which does have a 2.2 rating), instead of the movie (which has a 7.9 rating).

Another edge case I ran into Le Mozart des Pickpockets (year 2007 in the csv). This movie does actually exist, but the year is incorrect, it should actually be 2006. So currently it returns a "N/A" rating, but should have a 7.0. One way to fix this would be to simply search for the films by title only (then this film does return the correct rating). However, this causes problems for other films that have been remade such as True Grit (1969). If no year is provided, then the most recent True Grit (2010) would be returned, which is not the one requested in the csv. Because of this I decided to keep searching with both title and year.

Another edge case with a similar problem is Ersatz (1961). The call to the API for this film comes up with nothing, because the database actually has the translated title "The Substitute" (at least this is the only film I could find with "Ersatz" in the title in 1961). There are however other films with the title "Ersatz" in other years, so if I searched without the year then it would return a rating for the 2012 short film.

The last edge case I ran into was the film Wasp (2004). Luckily this film returns an "N/A" rating, because it actually has the wrong year. The API call does return a film "Wasp Woman" though. The year for the film should actually be 2003. Then it would return the correct rating.

I am sure there were some other edge cases with similar problems (wrong title, wrong year), that is the nature of data entry. Although I did not implement it, for the future to combat this problem I would probably make some sort of method that tries to get the film based the title and year entered and if no rating is returned throw an error asking the user to check the film or more practically do a broader search (in the API call, using "s= title" instead of "t=title" and no year), which would return a list of potential movies the might have meant. I think that would help to prevent any future entry problems (assuming there is some sort of UI), but does not solve the problem of getting incorrect data from the csv.

I included these edge cases and the correct entries in the movie_exceptions.csv to show the difference (and where possible I included both in the short_movies.csv). I also included so other movies just to fill out the report a little more for testing.

Overall it took me about and hour and a half to get the program functioning, a little over a half hour to handle the initial edge case (when the film isn't in the database), and then some more time to write this readme. So it took me just about two hours to produce this code and then probably another hour or so looking for edge cases,documenting, and producing the readme. I didn't want to go much over two hours, so I didn't get a chance to clean up the code or refactor much. But I really enjoyed working on the problem.
