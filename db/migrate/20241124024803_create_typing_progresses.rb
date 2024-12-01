# frozen_string_literal: true

class CreateTypingProgresses < ActiveRecord::Migration[7.2]
  def change
    create_table :typing_progresses do |t|
      t.integer :game_id
      t.integer :success_count
      t.integer :error_count
      t.integer :elapsed_time
      t.integer :user_id
      t.text :sentence_id

      t.timestamps
    end
  end
end
