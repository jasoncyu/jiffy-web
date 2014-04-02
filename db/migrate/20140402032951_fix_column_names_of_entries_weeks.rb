class FixColumnNamesOfEntriesWeeks < ActiveRecord::Migration
  def change
    rename_column :entries_weeks, :weeks_id, :week_id
    rename_column :entries_weeks, :entries_id, :entry_id
  end
end
