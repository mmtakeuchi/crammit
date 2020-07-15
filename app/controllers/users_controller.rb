class UsersController < ApplicationController

    get '/signup' do
        erb :"/users/signup"
    end

    post '/signup' do
        @user = User.new(params[:user])
        if @user.save
            session[:user_id] = @user.id
            redirect '/'
        else
            redirect '/signup'
        end
    end

    get '/login' do
        if logged_in?
            redirect '/'
        else
            erb :"/users/login"
        end
    end

    post '/login' do
        @user = User.find_by_username(params[:user][:username])
        if @user && @user.authenticate(params[:user][:password])
            session[:user_id] = @user.id
            redirect '/'
        else
            erb :"/users/login"
        end
    end
end