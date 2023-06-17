class AddRoleToPlayerParticipations < ActiveRecord::Migration[5.0]
  def change
    add_column :player_participations, :role, :string
  end
end
