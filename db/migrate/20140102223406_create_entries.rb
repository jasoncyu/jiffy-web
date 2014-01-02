class CreateEntries < ActiveRecord::Migration
  def change
    create_table :entries do |t|
      t.integer :project_id
      t.integer :user_id
      t.datetime :start_time
      t.datetime :end_time
      t.integer :hours
      t.integer :minutes
      t.string :note
      
      t.timestamps
    end
  end
end
