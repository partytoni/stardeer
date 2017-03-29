class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  protect_from_forgery with: :exception

  def page_not_found
    respond_to do |format|
      format.all  { redirect_to '/404' }
    end
  end

  rescue_from ActiveRecord::RecordNotFound do |e|
    redirect_to '/', :alert => "Non esiste nessun post con questo ID"
  end


end
