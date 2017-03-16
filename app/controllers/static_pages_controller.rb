require 'instagram'
require 'net/http'
require 'uri'

class StaticPagesController < ApplicationController
  helper_method :get_spots
  helper_method :yelp_spots
  helper_method :yelp_review
  helper_method :get_reviews
  helper_method :get_photos
  helper_method :get_image
  helper_method :get_place_by_id
  helper_method :instagram_photos


  def home
  end

  def result
  end

  def googledetails
  end

  def yelpdetails
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

  def yelp_spots()
    @client=Yelp.client
    params = {}
    locale = { lang: 'it' }
    coordinates = { latitude: session[:lat], longitude: session[:lng] }
    return @client.search_by_coordinates(coordinates, params, locale).businesses
  end

  def yelp_review(id)
    @client=Yelp.client
    locale = { lang: 'it' }
    list=[]
    business= (@client.business(id, locale)).business
    list << business.name
    if business.reviews!=nil
      list << business.reviews[0].excerpt
      list << business.reviews[0].rating
      list << business.reviews[0].user["name"]
    else
      list << ""
      list << ""
      list << ""
    end
    list << business.url
    list << business.image_url
  end
end
