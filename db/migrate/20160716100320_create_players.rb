class CreatePlayers < ActiveRecord::Migration[5.0]
  def change
    create_table :players do |t|
      t.integer :original_id, limit: 8
      t.string :name
      t.index :original_id, unique: true

      t.timestamps
    end
  end
end
