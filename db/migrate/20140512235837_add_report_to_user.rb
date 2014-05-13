class AddReportToUser < ActiveRecord::Migration
  def change
    add_column :users, :report, :string
  end
end
