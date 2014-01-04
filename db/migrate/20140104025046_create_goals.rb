class CreateGoals < ActiveRecord::Migration
  def change
    create_table :goals do |t|
      t.integer :goal_type
      t.integer :amount

      t.timestamps
    end
  end
end
