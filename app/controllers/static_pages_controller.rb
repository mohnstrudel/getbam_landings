class StaticPagesController < ApplicationController
  include Predict

  def learning
  end

  def populating
  	cities = Array.new
  	music_instrument = Array.new
  	favorite_star = Array.new
  	favorite_beer_style = Array.new
  	users = Array.new

  	# Create fixed, but random dictionary for population
  	10.times do |n|
  		cities << Faker::Address.city
  		music_instrument << Faker::Music.instrument
  		favorite_star << Faker::Space.star
  		favorite_beer_style << Faker::Beer.style
  	end

  	genders = ["male", "female"]

  	# Let's create a favorite landing for each user
  	labels = Array.new(50, 1).map { |n| n * rand(1..5)}

  	50.times do |n|
  		current_user = {"city" => cities.sample, "music_instrument" => music_instrument.sample, "favorite_star" => favorite_star.sample, "favorite_beer_style" => favorite_beer_style.sample, "age" => rand(5..80)}
  		users << current_user
  	end

  	@users = users
  	user_to_predict = {"city" => cities.sample, "music_instrument" => music_instrument.sample, "favorite_star" => favorite_star.sample, "favorite_beer_style" => favorite_beer_style.sample, "age" => rand(5..80)}
  	@prediction = Predict::execute(users, labels, user_to_predict)
  	@user_to_predict = user_to_predict
  end
end
