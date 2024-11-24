class RenameGameIdToGame < ActiveRecord::Migration[7.2]
  def change
    rename_table :typing_game_ids, :typing_games
  end
end
