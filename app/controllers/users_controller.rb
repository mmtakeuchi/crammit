class UsersController < ApplicationController

    get '/signup' do
        erb :"/users/signup"
    end

    post '/signup' do
        @user = User.new(params[:user])
        if @user.save
            redirect '/'
        else
            redirect '/signup'
        end
    end
end