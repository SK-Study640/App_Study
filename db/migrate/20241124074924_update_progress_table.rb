# frozen_string_literal: true

class UpdateProgressTable < ActiveRecord::Migration[7.2]
  def change
    # success_countとerror_countを削除
    remove_column :typing_progresses, :success_count, :integer
    remove_column :typing_progresses, :error_count, :integer

    add_column :typing_progresses, :is_success, :boolean, default: false, null: false
  end
end
