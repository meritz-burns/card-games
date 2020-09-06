class CreateGames < ActiveRecord::Migration[6.0]
  def change
    create_table :games do |t|
      t.timestamps null: false

      t.integer :state, default: 0, null: false
      t.string :deck_ids, default: [], null: false, array: true
      t.string :discard_ids, default: [], null: false, array: true
    end

    add_index :games, :state
  end
end
