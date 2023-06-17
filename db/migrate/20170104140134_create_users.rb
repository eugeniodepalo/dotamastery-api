class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :name
      t.integer :original_id, limit: 8
      t.string :auth_token
      t.index :auth_token, unique: true
      t.index :original_id, unique: true

      t.timestamps
    end
  end
end
