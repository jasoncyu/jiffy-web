class RedoEntriesAndWeeks < ActiveRecord::Migration
  def change
    drop_table :weeks
    create_table :weeks do |t|
      t.date :start_day
      t.integer :entry_id
      t.timestamps
    end

    create_table :weeks_entries do |t|
      t.belongs_to :weeks
      t.belongs_to :entries
    end

  end
end
