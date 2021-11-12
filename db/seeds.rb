# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'json'
require 'open-uri'

url = 'http://tmdb.lewagon.com/movie/top_rated'

# puts "#{results["results"][1]["title"]} - #{results["results"][1]["release_date"]} - #{results["results"][1]["overview"]} - #{results["results"][1]["poster_path"]} "

puts 'destroying movies'
Movie.destroy_all
puts 'creating movies'
10.times do |i|
  movies = JSON.parse(open("#{url}?page=#{i + 1}").read)['results']
  movies.each do |m|
    main_url = "https://image.tmdb.org/t/p/original"
    Movie.create(
      title: m['title'],
      overview: m['overview'],
      poster_url: "#{[main_url]}#{m['poster_path']}",
      rating: m['vote_average']
    )
  end
end
puts "#{Movie.count} tasks were created successfully."
