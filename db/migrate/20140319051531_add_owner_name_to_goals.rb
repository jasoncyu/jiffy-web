class AddOwnerNameToGoals < ActiveRecord::Migration
  def change
    add_column :goals, :owner_name, :text
  end
end
