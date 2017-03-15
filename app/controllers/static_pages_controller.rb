require 'instagram'

class StaticPagesController < ApplicationController
  helper_method :get_spots
  helper_method :get_reviews
  helper_method :get_place_by_id
  helper_method :instagram_photos


  def home
  end

  def result
  end

  def details
  end



private
  def get_spots(address)
    a=Geokit::Geocoders::GoogleGeocoder.geocode(address)
    lat=(a.ll).split(",")[0]
    lng=(a.ll).split(",")[1]
    @client = GooglePlaces::Client.new("AIzaSyDseOM0g-hw8x_uG1EYJOFQ4uMMR8U57KA")
    @spots = @client.spots(lat, lng)
    return @spots
  end

  def get_reviews(place_id)
    @client = GooglePlaces::Client.new("AIzaSyDseOM0g-hw8x_uG1EYJOFQ4uMMR8U57KA")
    reviews = @client.spot(place_id).reviews
    return reviews
  end


  def get_place_by_id(place_id)
    @client = GooglePlaces::Client.new("AIzaSyDseOM0g-hw8x_uG1EYJOFQ4uMMR8U57KA")
    return @client.spot(place_id)
  end

  def instagram_photos
      redirect_to Instagram.authorize_url(:redirect_uri => CALLBACK_URL)
  end
end
