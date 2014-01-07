require 'csv'
# 2013.csv has all the 2013 records
# jiffy.csv has the latest records
class Entry < ActiveRecord::Base
  include Comparable

  validates :start_time, uniqueness: true, presence: true
  validates :stop_time, uniqueness: true, presence: true
  belongs_to :project
  belongs_to :task
  belongs_to :week
  dir_name = '/Users/yujason2/Dropbox/Apps/JiffyBackup/2013.csv'

  # attr_accessor :start_time, :stop_time, :task_id, :project_id, :hours, :minutes, :note
  def duration
    hours + minutes.to_f/60
  end
  
  def self.parse_entries(file_name)

  end
end
