require './config/environment'
require 'rack-flash'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "sinatra_secrets"
  end

  get "/" do
    erb :welcome
  end

  helpers do
    def current_user
      User.find_by_id(session[:user_id])
    end

    def logged_in?
      !!session[:user_id]
    end
  end

  private

  def redirect_if_not_logged_in
    if !logged_in?
      redirect '/'
    end
  end
end
