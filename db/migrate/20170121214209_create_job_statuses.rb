class CreateJobStatuses < ActiveRecord::Migration[5.0]
  def change
    create_table :job_statuses do |t|
      t.references :user, foreign_key: true
      t.string :name
      t.index [:user_id, :name], unique: true
      
      t.timestamps
    end
  end
end
