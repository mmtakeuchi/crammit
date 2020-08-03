class FlashcardsController < ApplicationController
    use Rack::Flash

    get "/flashcards" do
        redirect_if_not_logged_in

        @flashcards = current_user.flashcards
        erb :"flashcards/index"
    end

    get "/flashcards/new" do
        redirect_if_not_logged_in

        erb :"flashcards/new"
    end

    post "/flashcards" do
        redirect_if_not_logged_in

        @flashcard = current_user.flashcards.build(params[:flashcard])
        if @flashcard.save
            redirect "/flashcards"
        else
            erb :'flashcards/new'
        end
    end

    get "/flashcards/:id/edit" do
        @flashcard = Flashcard.find_by_id(params[:id])
        if @flashcard       
            if logged_in? && current_user == @flashcard.user
                erb :'flashcards/edit'
            else
                redirect "/flashcards"
            end
        else
            redirect "/"
        end
    end

    get "/flashcards/:id" do

        set_flashcard

        if logged_in? && current_user == @flashcard.user
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
                    definition: params[:flashcard][:answer]
                )
                redirect "/flashcards/#{@flashcard.id}"
            else
                erb :'flashcards/edit'
            end
        else
            redirect "/flashcards"
        end
    end

    delete "/flashcards/:id" do
        @flashcard = Flashcard.find_by_id(params[:id])

        if current_user == @flashcard.user
            @flashcard.destroy
        end
        
        redirect "/flashcards"
    end

    private

    def set_flashcard
        @flashcard = Flashcard.find_by_id(params[:id])

        if !@flashcard
            redirect '/flashcards'
        end
    end
end