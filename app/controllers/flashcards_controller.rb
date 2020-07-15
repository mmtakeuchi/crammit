class FlashcardsController < ApplicationController

    get '/flashcards' do
        erb :"flashcards/index"
    end
end