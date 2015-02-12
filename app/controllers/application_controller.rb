class ApplicationController < ActionController::Base
  protect_from_forgery


  def current_location
    @current_location ||= request.location.data
  end
  helper_method :current_location

end
