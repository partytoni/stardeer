require 'instagram'
require 'net/http'
require 'uri'
class StaticPagesController < ApplicationController
  helper_method :get_spots
  helper_method :get_reviews
  helper_method :get_photos
  helper_method :get_image
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
    session[:lat]=lat
    session[:lng]=lng
    @client = GooglePlaces::Client.new("AIzaSyDseOM0g-hw8x_uG1EYJOFQ4uMMR8U57KA")
    @spots = @client.spots(lat, lng)
    return @spots
  end

  def get_reviews(place_id)
    @client = GooglePlaces::Client.new("AIzaSyDseOM0g-hw8x_uG1EYJOFQ4uMMR8U57KA")
    reviews = @client.spot(place_id).reviews
    return reviews
  end

  def get_photos(place_id)
    @client = GooglePlaces::Client.new("AIzaSyDseOM0g-hw8x_uG1EYJOFQ4uMMR8U57KA")
    reviews = @client.spot(place_id).photos
  end

  def get_image(link)
    uri = URI.parse(link)
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    request = Net::HTTP::Get.new(uri.request_uri)
    response = http.request(request)
    string= (response.body).to_s
    split1=string.split("<A HREF=\"")[1]
    final_link=split1.split("\"")[0]
    return final_link
  end


  def get_place_by_id(place_id)
    @client = GooglePlaces::Client.new("AIzaSyDseOM0g-hw8x_uG1EYJOFQ4uMMR8U57KA")
    return @client.spot(place_id)
  end

  def instagram_photos
    #TODO
  end
end
