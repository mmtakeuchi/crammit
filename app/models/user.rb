class User < ActiveRecord::Base
    has_many :flashcards

    validates :username, presence: true, uniqueness: true
    validates :password, presence: true
end
