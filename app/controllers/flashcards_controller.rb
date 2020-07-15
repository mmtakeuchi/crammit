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
            erb :'flashcards/new'
        end
    end

    get "/flashcards/:id/edit" do
        @flashcard = Flashcard.find_by_id(params[:id])
        if current_user = @flashcard.user
            erb :'flashcards/edit'
        else
            redirect "/flashcards"
        end
    end

    get "/flashcards/:id" do
        @flashcard = Flashcard.find_by_id(params[:id])
        if @flashcard
            erb :'flashcards/show'
        else
            redirect "/flashcards"
        end
    end

    patch "/flashcards/:id" do
        @flashcard = Flashcard.find_by_id(params[:id])

        if current_user == @flashcard.user 
            if @flashcard.term != "" || @flashcard.definition != ""
                @flashcard.update(
                    term: params[:flashcard][:term],
                    definition: params[:flashcard][:definition]
                )
                redirect "/flashcards/#{@flashcard.id}"
            else
                erb :'flashcards/edit'
            end
        else
            redirect "/flashcards"
        end
    end
end