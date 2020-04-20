class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include SessionsHelper
  
  respond_to :html, :json

  def authorize
    redirect_to root_url unless logged_in?
  end

end
