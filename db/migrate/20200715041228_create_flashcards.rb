class CreateFlashcards < ActiveRecord::Migration
  def change
    create_table :flashcards do |t|
      t.string :term
      t.string :definition
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
