# frozen_string_literal: true

class CreateTypingGameIds < ActiveRecord::Migration[7.2]
  def change
    create_table :typing_game_ids do |t|
      t.integer :user_id

      t.timestamps
    end
  end
end
