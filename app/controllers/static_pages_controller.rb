require 'net/http'
require 'uri'

class StaticPagesController < ApplicationController
  before_action :banned?


  def home
  end

  def ban
    if !current_user.superadmin_role? and !current_user.supervisor_role?
      redirect_to '/', :alert => "You shall not ass"
    else
      @users=User.all
    end
  end

  def result
  end

  def googledetails
  end

  def yelpdetails
  end

  def foursquaredetails
  end

  def banned?
    if User.find(current_user.id).banned
      sign_out current_user
      redirect_to '/', :alert => "Sei bannato."
    end
  end



end
