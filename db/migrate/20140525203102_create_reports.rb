class CreateReports < ActiveRecord::Migration
  def change
    create_table :reports do |t|
      t.string :jiffy_summary
      t.timestamps
    end
  end
end
