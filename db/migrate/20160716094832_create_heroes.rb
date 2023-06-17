class CreateHeroes < ActiveRecord::Migration[5.0]
  def change
    create_table :heroes do |t|
      t.string :name
      t.string :portrait_url
      t.integer :original_id, limit: 8
      t.index :original_id, unique: true

      t.timestamps
    end
  end
end
