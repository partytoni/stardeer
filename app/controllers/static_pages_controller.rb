class StaticPagesController < ApplicationController
  helper_method :get_reviews

  def home
  end

  def result
  end

private
  def get_reviews(address)
    s=""
    a=Geokit::Geocoders::GoogleGeocoder.geocode(address)
    lat=(a.ll).split(",")[0]
    lng=(a.ll).split(",")[1]
    @client = GooglePlaces::Client.new("AIzaSyDseOM0g-hw8x_uG1EYJOFQ4uMMR8U57KA")
    @spots = @client.spots(lat, lng)
    for elem in @spots
      if elem.rating.to_s!=""
        s=s+elem.name.to_s+", rated: "+elem.rating.to_s+""
      end
    end
    return s
  end
end
