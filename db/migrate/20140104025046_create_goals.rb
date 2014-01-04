class CreateGoals < ActiveRecord::Migration
  def change
    create_table :goals do |t|
      t.integer :goal_type
      t.integer :amount
      t.string :type
      t.integer :task_id
      t.integer :project_id

      t.timestamps
    end
  end
end
