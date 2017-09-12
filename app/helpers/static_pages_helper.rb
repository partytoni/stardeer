module StaticPagesHelper
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

  def get_spot_address(place_id) #google places
    # hash_address ha types, long_name, short_name e i types sono "route, street_number, locality, country, postal_code"
    @client = GooglePlaces::Client.new("AIzaSyDseOM0g-hw8x_uG1EYJOFQ4uMMR8U57KA")
    hash_address=Hash.new
    addresses = @client.spot(place_id).address_components
    addresses.each do |a|
      if a["types"][0]=="country" #per country c'è bisogno del cc
        hash_address[a["types"][0]]=a["short_name"]
      else
        hash_address[a["types"][0]]=a["long_name"]
      end
    end
    hash_address
  end

  def get_google_spot_address(place_id)
    hash=get_spot_address(place_id)
    list=[]
    list << hash["route"].to_s + " " + hash["street_number"].to_s
    list << hash["locality"]
    list << hash["country"]
  end

  def get_spot_location(place_id) #google location
    # hash_address ha types, long_name, short_name e i types sono "route, street_number, locality, country, postal_code"
    @client = GooglePlaces::Client.new("AIzaSyDseOM0g-hw8x_uG1EYJOFQ4uMMR8U57KA")
    hash_address=Hash.new
    addresses = [@client.spot(place_id)[:lat],@client.spot(place_id)[:lng]]
    addresses
  end

  def yelp_spot_address(id)
    @client=Yelp.client
    locale = { lang: 'it' }
    list=[]
    business= (@client.business(id, locale)).business
    list << business.location.address[0]
    list << business.location.city
    list << business.location.country_code
    list
  end


  def get_reviews(place_id)
    @client = GooglePlaces::Client.new("AIzaSyDseOM0g-hw8x_uG1EYJOFQ4uMMR8U57KA")
    reviews = @client.spot(place_id).reviews
    return reviews
  end

  def get_photos(place_id)
    @client = GooglePlaces::Client.new("AIzaSyDseOM0g-hw8x_uG1EYJOFQ4uMMR8U57KA")
    photos = @client.spot(place_id).photos
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
    print("\n\n\n["+place_id.class.to_s+"]\n\n\n")
    return @client.spot(place_id)
  end

  def yelp_spots()
    @client=Yelp.client
    params = {}
    locale = { lang: 'it' }
    coordinates = { latitude: session[:lat], longitude: session[:lng] }
    begin
      @client.search_by_coordinates(coordinates, params, locale).businesses
    rescue => error
      return []
    end
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



  def foursquare_spots()
    client = Foursquare2::Client.new(:client_id => 'YOY24IGK0SILRQEZ4KBQNAFD3GNAHA0Z5SFDBX34M1AS4LYP',
     :client_secret => 'MQNG4KGWGT0T4DYIYVAFRSJ5JW4U0TDONBDM02MARDWQA3UX',
     :api_version => '20120609')
    spots=client.search_venues(:ll => session[:lat]+","+session[:lng])
  end

  def foursquare_spot(id)
    client = Foursquare2::Client.new(:client_id => 'YOY24IGK0SILRQEZ4KBQNAFD3GNAHA0Z5SFDBX34M1AS4LYP',
     :client_secret => 'MQNG4KGWGT0T4DYIYVAFRSJ5JW4U0TDONBDM02MARDWQA3UX',
     :api_version => '20120609')
    s = client.venue(id)
    res = Hash.new
    res["name"] = s.name
    if s.rating!=nil
      res["rating"] = (s.rating).to_s + "su 10"
    else
      res["rating"] = "Nessuno"
    end
    res["phrases"] = s.phrases
    res["photos"] = []
    begin
      s.photos[:groups][0][:items].each do |i|
          res["photos"] << i[:prefix]+"500x300"+i[:suffix]
      end
    rescue
    end
    res
  end

  def foursquare_spot_address(id)
    client = Foursquare2::Client.new(:client_id => 'YOY24IGK0SILRQEZ4KBQNAFD3GNAHA0Z5SFDBX34M1AS4LYP',
     :client_secret => 'MQNG4KGWGT0T4DYIYVAFRSJ5JW4U0TDONBDM02MARDWQA3UX',
     :api_version => '20120609')
    s = client.venue(id)
    s.location
  end

  def get_foursquare_spot_address(id)
    f=foursquare_spot_address(id)
    list=[]
    list << f["address"]
    list << f["city"]
    list << f["cc"]
    list
  end

#  def stampa(stringa)
#    num=0
#    stringa.each_char do |s|
#      if s=="<"
#        num=num+1
#        print("\n"+("\t")*num+s)
#      elsif s==">"
#        num=num-1
#        print(s+"\n"+("\t")*num)
#      else
#        print(s)
#      end
#    end
#  end

  def get_our_reviews(site, place_id)
    @place = Place.find_by place_id:place_id, site:site
    if @place
      @posts = []
      p=Post.where(place_id:@place.id)
      if p.class==Post
        @posts << p
      else #p.class=nil
        @posts=p
      end
      @posts
    else
      []
    end
  end

  def get_user_email(id)
    User.find(id).email
  end

  def post_already_created?(posts)
    posts.each do |p|
      if p.user_id==current_user.id
        return true
      end
    end
    false
  end

  def already_followed?(uid, currentid)
    cose=Relationship.where(["follower_id = ? and followed_id = ?", currentid, uid])
    if cose==[]
      return false
    else
      return true
    end
  end
end

def callback_url(post)
  place=Place.find(post.place_id)
  site=place.site
  if site=='google'
    site='googledetails'
  elsif site=='yelp'
    site='yelpdetails'
  elsif site=='foursquare'
    site='foursquaredetails'
  end
  place_id=place.place_id
  ret="/"+site+"?id="+place_id
  ret
end

def from_post_to_place(post)
  place=Place.where("id =" + post.place_id.to_s).first
end

def from_user_to_posts(user)
  post=Post.where("id =" + user.id.to_s)
end

def from_post_to_user(post)
  user=User.where("id =" + post.post_id.to_s).first
end
