class UsersController < ApplicationController

    get "/signup" do
        erb :'users/signup'
    end

    post "/signup" do
        @user = User.new(params[:user])
        if @user.save
            session[:user_id] = @user.id
            redirect "/flashcards"
        else
            erb :'users/signup'
        end
    end

    get "/login" do
        erb :'users/login'
    end

    post "/login" do
        @user = User.find_by_username(params[:user][:username])
        if @user && @user.authenticate(params[:user][:password])
            session[:user_id] = @user.id
            redirect "/flashcards"
        else
            erb :'users/login'
        end
    end

    get "/logout" do
        session.clear
        redirect "/"
    end
end