# Beatport

A ruby gem for accessing the Beatport API

http://api.beatport.com

Currently incomplete, but under development. 

[![Dependency Status](https://gemnasium.com/mateomurphy/beatport.png)](https://gemnasium.com/mateomurphy/beatport)

## Oauth

Beatport's api now requires authentication via Oauth. This means you now need to provide the gem
your oauth credentials to make requests, for example in a rails initializer:

    Beatport.consumer_key =        'consumer_key'
    Beatport.consumer_secret =     'consumer_secret'
    Beatport.access_token_key =    'access_token_key'
    Beatport.access_token_secret = 'access_token_secret'

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

  query[0].class # => first result is a Beatport::Catalog::Artist object
  query[0].id # => returns the Beatport id of the artist

  query[1].class # => second result is a Beatport.Catalog::Chart object
  query[1].publish_date # => returns the published date of the Chart

  # Note that search results change frequently, so first result may not necessarily be a Beatport::Catalog::Artist object

  # Find top downloads for a given genre
  genres = Beatport::Catalog::Genre.all # => list all genres
  # display each genre and its corresponding Beatport genre slug

  genres.each do |genre|
    puts "Genre: #{genre.name} slug: #{genre.slug}"
  end
  
  # find the top 10 downloads for the genre Electro House
  electro_house_genre = Beatport::Catalog::Genre.find('electro-house') 
  # => create Electro House Genre object by searching by slug

  electro_house_top_10 = trance_genre.top_downloads
  # => list the top downloads for the Electro House genre

  electro_house_top_10[0].name
  # => find the name of the #1 downloaded Electro House track

  # An alternative for searching for genre by slug is searching by genre ID
  trance_genre = Beatport::Catalog::Genre.find(7) # => returns a Trance Genre object
  ```

## Running specs

To run specs, you'll need to create a file with your oauth credentials in `spec/config.rb`, which
will be loaded by `spec/spec_helper.rb`

## Contributing to beatport
 
* Check out the latest master to make sure the feature hasn't been implemented or the bug hasn't been fixed yet
* Check out the issue tracker to make sure someone already hasn't requested it and/or contributed it
* Fork the project
* Start a feature/bugfix branch
* Commit and push until you are happy with your contribution
* Make sure to add tests for it. This is important so I don't break it in a future version unintentionally.
* Please try not to mess with the Rakefile, version, or history. If you want to have your own version, or is otherwise necessary, that is fine, but please isolate to its own commit so I can cherry-pick around it.

## Copyright

Copyright (c) 2011-2013 Mateo Murphy. See LICENSE.txt for
further details.

