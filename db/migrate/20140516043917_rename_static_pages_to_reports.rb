class RenameStaticPagesToReports < ActiveRecord::Migration
  def change
    rename_table :static_pages, :reports
  end
end
