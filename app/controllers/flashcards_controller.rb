class FlashcardsController < ApplicationController

    get "/flashcards" do
        @flashcards = Flashcard.all
        erb :"flashcards/index"
    end

    get "/flashcards/new" do
        erb :"flashcards/new"
    end
end