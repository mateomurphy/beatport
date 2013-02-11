require 'beatport'
# Search using the query "Mord Fustang" on Beatport
  query = Beatport::Catalog::Search.query("mord fustang")
  # returns a Beatport::Collection object
  query.class # => Beatport::Collection

  query.to_a[0].class # first result is a Beatport::Catalog::Artist object
  query.to_a[0].id # => returns the Beatport id of the artist

  query.to_a[1].class # => second result is a Beatport.Catalog::Chart object
  query.to_a[1].publish_date # => returns the published date of the Chart

# Find top downloads for a given genre
  genres = Beatport::Catalog::Genre.all # => list all genres
  # display each genre and its corresponding Beatport genre ID
  genres.each do |genre|
    puts "Genre: #{genre.name} id: #{genre.id}"
  end
  # find the top 10 downloads for the genre Trance
  trance_genre = Beatport::Catalog::Genre.find(7) # => create Trance Genre object
  trance_top_10 = trance_genre.top_downloads 
  # find the name of the #1 downloaded track
   trance_top_10[0].name
