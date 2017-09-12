class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource
  helper_method :create_review
  helper_method :yelp_spot_address
  helper_method :foursquare_spot_address

  # GET /posts
  # GET /posts.json
  def index
    redirect_to '/404'
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    redirect_to '/404'
  end

  # GET /posts/new
  def new
    @post = Post.new
    if params[:site]!=nil and params[:id]!=nil
      session[:site]=params[:site]
      session[:place_id]=params[:id]
      #session[:rating] = params[:rating]
    else
      redirect_to '/404'
    end
  end

  # GET /posts/1/edit
  def edit
    post=Post.find(params[:id])
    if post==nil
      redirect_to '/404'
    elsif post.user_id!=current_user.id
      redirect_to '/404'
    else
      return
    end
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = Post.new(post_params)
    @post.user_id=current_user.id
    create_review(@post)
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to callback_url(@post), notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to callback_url(@post), notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private


  # Use callbacks to share common setup or constraints between actions.
  def set_post
    @post = Post.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def post_params
    params.require(:post).permit(:text, :rating)
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

  def create_review(post)
    if session[:site]=="foursquare"
      a=foursquare_spot_address(session[:place_id])
      @place=place_obj(a)
    elsif session[:site] == "google"
      a = get_google_spot_address(session[:place_id])
      @place=place_obj(a)
    elsif session[:site] == "yelp"
      a=yelp_spot_address(session[:place_id])
      @place=place_obj(a)
    end

    if @place==nil #se non esiste già un place, lo crea
      @place=Place.new
      @place.address=a[0]
      @place.city=a[1]
      @place.place_id=session[:place_id]
      @place.cc=a[2]
      @place.name=a[3]
      @place.site=session[:site]
      n=Place.maximum(:id)
      if n==nil
        @place.id=0
      else
        @place.id=n.next
      end
      #se non è andato a buon fine la creazione del place ritorna errore
    end


    p=Post.where(user_id:current_user.id, place_id:@place.id)
    @post=post
    @post.place=@place
    if p.length!=0
      redirect_to callback_url(@post), :alert => "Recensione già inserita"
    else
      if not ( @post.save and @place.save)
        return false
      end
      redirect_to callback_url(@post), :alert => "Post Creato Correttamente"
    end
    #dopo aver verificato che il place sia nel database si crea il post
    #TODO in @place ci sta il place da considerare

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
    hash_address["name"]= @client.spot(place_id).name
    hash_address

  end

  def get_google_spot_address(place_id)
    hash=get_spot_address(place_id)
    list=[]
    list << hash["route"].to_s + " " + hash["street_number"].to_s
    list << hash["locality"]
    list << hash["country"]
    list << hash["name"]
  end

  def yelp_spot_address(id)
    @client=Yelp.client
    locale = { lang: 'it' }
    list=[]
    business= (@client.business(id, locale)).business
    list << business.location.address[0]
    list << business.location.city
    list << business.location.country_code
    list << business.name
    list
  end

  def foursquare_spot_address(id)
    client = Foursquare2::Client.new(:client_id => 'YOY24IGK0SILRQEZ4KBQNAFD3GNAHA0Z5SFDBX34M1AS4LYP',
     :client_secret => 'MQNG4KGWGT0T4DYIYVAFRSJ5JW4U0TDONBDM02MARDWQA3UX',
     :api_version => '20120609')
    s = client.venue(id).location
    list=[]
    list << s["address"]
    list << s["city"]
    list << s["cc"]
    list << foursquare_spot(id)["name"]
    list
  end

  def place_obj(params)
    @places=Place.all
    @places.each do |place|
      if place.address==params[0] and place.city==params[1] and place.cc==params[2]
        return place
      end
    end
    nil
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
    s.photos[:groups][0][:items].each do |i|
        res["photos"] << i[:prefix]+"500x300"+i[:suffix]
    end
    res
  end
end
