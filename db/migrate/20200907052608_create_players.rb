class CreatePlayers < ActiveRecord::Migration[6.0]
  def change
    create_table :players do |t|
      t.timestamps null: false
      t.belongs_to :game, null: false
      t.string :name, null: false
      t.string :connection_secret, null: false
      t.string :hand_ids, default: [], null: false, array: true
      t.string :board_ids, default: [], null: false, array: true
    end

    add_index :players, :connection_secret
  end
end
