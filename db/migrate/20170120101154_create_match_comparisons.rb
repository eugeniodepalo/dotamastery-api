class CreateMatchComparisons < ActiveRecord::Migration[5.0]
  def change
    create_table :match_comparisons do |t|
      t.float :similarity
      t.references :match, foreign_key: true
      t.references :other_match, foreign_key: { to_table: :matches }

      t.timestamps
    end
  end
end
