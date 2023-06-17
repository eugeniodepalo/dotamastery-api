class CreateMatches < ActiveRecord::Migration[5.0]
  def change
    create_table :matches do |t|
      t.integer :original_id, limit: 8
      t.datetime :started_at
      t.integer :average_mmr
      t.string :winner
      t.references :user, foreign_key: true
      t.index [:user_id, :original_id], unique: true

      t.timestamps
    end
  end
end
