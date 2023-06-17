class CreateLiveMatches < ActiveRecord::Migration[5.0]
  def change
    create_table :live_matches do |t|
      t.integer :original_id, limit: 8
      t.integer :match_id, limit: 8
      t.integer :average_mmr
      t.datetime :finished_at
      t.index :original_id, unique: true

      t.timestamps
    end
  end
end
