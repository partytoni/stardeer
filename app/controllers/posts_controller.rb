class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  helper_method :create_review

  # GET /posts
  # GET /posts.json
  def index
    @posts = Post.all
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
  end

  # GET /posts/new
  def new
    @post = Post.new
    session[:site]=params[:site]
    session[:place_id]=params[:id]
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = Post.new(post_params)
    @post.user_id=current_user.id
    create_review(@post)
    redirect_to "/"
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
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
      format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
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
      params.require(:post).permit(:text)
    end


    def create_review(post)
      if session[:site]=="foursquare"
        a=get_foursquare_spot_address(session[:place_id])
        @place=place_obj(a)
      elsif session[:site] == "google"
        a = get_google_spot_address(session[:place_id])
        @place=place_obj(a)
      elsif session[:site] == "yelp"
        a=yelp_spot_address(session[:place_id])
        @place=place_obj(a)
      end
      if @place==nil
        @place=Place.new
        @place.address=a[0]
        @place.city=a[1]
        @place.cc=a[2]
        n=Place.maximum(:id)
        if n==nil
          @place.id=0
        else
          @place.id=n.next
        end

        print("\n\nPLACE: "+@place.address)
      #se non è andato a buon fine la creazione del place ritorna errore
      end
      #@place.post << post
      @post=post
      @post.place=@place
      if not ( @post.save)
        return false
      end
      #dopo aver verificato che il place sia nel database si crea il post
      #TODO in @place ci sta il place da considerare

    end

    def get_spot_address(place_id) #google places
      # hash_address ha types, long_name, short_name e i types sono "route, street_number, locality, country, postal_code"
      @client = GooglePlaces::Client.new("AIzaSyDseOM0g-hw8x_uG1EYJOFQ4uMMR8U57KA")
      hash_address=Hash.new
      print("\n\n\n\n"+place_id)
      addresses = @client.spot(place_id).address_components
      addresses.each do |a|
        print("\n\n\n"+a["types"][0].to_s+"\n\n\n")
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
      list << hash["route"] + " " + hash["street_number"]
      list << hash["locality"]
      list << hash["country"]
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

end
