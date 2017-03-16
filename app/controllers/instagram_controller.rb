class InstagramController < ApplicationController
  def login
    redirect_to "https://api.instagram.com/oauth/authorize/?client_id=951dbff4334f41158ed07f169c7ffc48&redirect_uri=http://localhost:3000/instagram/callback&response_type=token"
  end


  def callback
    redirect_to "/"
  end

end
