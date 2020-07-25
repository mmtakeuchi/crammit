class UsersController < ApplicationController
    use Rack::Flash

    get "/signup" do
        erb :'users/signup'
    end

    post "/signup" do
        @user = User.new(params[:user])
        if @user.save
            session[:user_id] = @user.id
            redirect "/flashcards"
        else
            flash.now[:notice] = "Username has already been taken. Please enter new username."
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
            flash.now[:notice] = "Username or password not recoginzed. Please enter new username and password."
            erb :'users/login'
        end
    end

    get "/logout" do
        session.clear
        redirect "/"
    end
end