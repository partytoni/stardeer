require_or_load 'instagram'
require_or_load 'oauth'
#require 'sinatra'

CALLBACK_URL = "http://localhost:3000/instagram/callback"

Instagram.configure do |config|
  config.client_id = "951dbff4334f41158ed07f169c7ffc48"
  config.client_secret = "daa064d1c3254ef7a72730ffa0146a43"
  # For secured endpoints only
  #config.client_ips = '<Comma separated list of IPs>'
end
