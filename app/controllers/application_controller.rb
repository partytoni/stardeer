class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  protect_from_forgery with: :exception

  def page_not_found
    respond_to do |format|
      format.html { render template: 'errors/not_found_error', layout: 'layouts/application', status: 404 }
      format.all  { render nothing: true, status: 404 }
    end
  end
  def path_error
    redirect_to '/404'
  end
  rescue_from Exception do |e|
    print("\n\nun errore, aiuto"+ e.to_s)
    path_error
  end
  rescue_from ActionController::RoutingError do |e|
    print("\n\nun errore, aiuto1"+ e.to_s)
    path_error
  end

end
