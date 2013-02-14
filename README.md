# Beatport

A ruby gem for accessing the Beatport API

http://api.beatport.com

Currently incomplete, but under development. 

[![Dependency Status](https://gemnasium.com/mateomurphy/beatport.png)](https://gemnasium.com/mateomurphy/beatport)

## Facets

Many queries to beatport support facets, but they aren't properly documentated on their site. These are the ones I've found so far:

* genreName
* artistName (and not performerName)
* labelName

## Examples

```ruby
require 'beatport'
# Search using the query "Mord Fustang" on Beatport
  query = Beatport::Catalog::Search.query("Mord Fustang")
  
  query.class # => returns a Beatport::Collection object

  query.to_a[0].class # => first result is a Beatport::Catalog::Artist object
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
  trance_top_10 = trance_genre.top_downloads # => list the top downloads for the Trance genre
  trance_top_10[0].name # => find the name of the #1 downloaded track
```

## Contributing to beatport
 
* Check out the latest master to make sure the feature hasn't been implemented or the bug hasn't been fixed yet
* Check out the issue tracker to make sure someone already hasn't requested it and/or contributed it
* Fork the project
* Start a feature/bugfix branch
* Commit and push until you are happy with your contribution
* Make sure to add tests for it. This is important so I don't break it in a future version unintentionally.
* Please try not to mess with the Rakefile, version, or history. If you want to have your own version, or is otherwise necessary, that is fine, but please isolate to its own commit so I can cherry-pick around it.

## Copyright

Copyright (c) 2011-2012 Mateo Murphy. See LICENSE.txt for
further details.

