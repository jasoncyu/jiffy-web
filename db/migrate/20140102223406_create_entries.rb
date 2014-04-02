class CreateEntries < ActiveRecord::Migration
  def change
    create_table :entries do |t|
      t.integer :project_id
      t.integer :task_id
      t.integer :week_id
      t.datetime :start_time
      t.datetime :stop_time
      t.integer :hours
      t.integer :minutes
      t.string :note
      
      t.timestamps
    end
  end
end
