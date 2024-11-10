class CreateTypingSentences < ActiveRecord::Migration[7.2]
  def change
    create_table :typing_sentences do |t|
      t.string :content

      t.timestamps
    end
  end
end
