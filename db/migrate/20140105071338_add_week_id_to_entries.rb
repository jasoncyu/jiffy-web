class AddWeekIdToEntries < ActiveRecord::Migration
  def change
    add_column :entries, :week_id, :integer
  end
end
