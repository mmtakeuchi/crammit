class FlashcardsController < ApplicationController

    get '/flashcards' do
        @flashcards = Flashcard.all
        erb :"flashcards/index"
    end
end