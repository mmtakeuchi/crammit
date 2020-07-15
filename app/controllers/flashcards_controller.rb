class FlashcardsController < ApplicationController

    get "/flashcards" do
        @flashcards = current_user.flashcards
        erb :"flashcards/index"
    end

    get "/flashcards/new" do
        erb :"flashcards/new"
    end

    post "/flashcards" do
        @flashcard = current_user.flashcards.build(params[:flashcard])
        if @flashcard.save
            redirect "/flashcards"
        else
            erb :'/flashcards/new'
        end
    end
end