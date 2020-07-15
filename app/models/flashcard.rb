class Flashcard < ActiveRecord::Base
    belongs_to :user

    validates :term, presence: true
    validates :definition, presence: true
end
