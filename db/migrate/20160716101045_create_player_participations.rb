class CreatePlayerParticipations < ActiveRecord::Migration[5.0]
  def change
    create_table :player_participations do |t|
      t.references :match, foreign_key: true
      t.references :player, foreign_key: true
      t.references :hero, foreign_key: true
      t.string :side
      t.string :lane
      t.integer :slot

      t.timestamps
    end
  end
end
