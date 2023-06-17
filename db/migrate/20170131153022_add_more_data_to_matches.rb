class AddMoreDataToMatches < ActiveRecord::Migration[5.0]
  def change
    add_column :matches, :region, :string
    add_column :matches, :duration, :integer
  end
end
