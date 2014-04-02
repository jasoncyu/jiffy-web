class FixJoinTableName < ActiveRecord::Migration
  def change
    rename_table :weeks_entries, :entries_weeks
  end
end
