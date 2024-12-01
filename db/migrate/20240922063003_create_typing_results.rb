# frozen_string_literal: true

class CreateTypingResults < ActiveRecord::Migration[7.2]
  def change
    create_table :typing_results do |t|
      t.integer :time
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
