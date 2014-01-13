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

  # pretty prints either start time or stop time
  def pretty(key)
    self.send(key.to_sym).strftime("%m-%d-%Y %k:%M")
  end
  
  def self.parse_entries(file_name)

  end

  #returns duplicates if there are any, else empty
  def self.dup_entries
    Entry.all.select {|e| !e.valid?}
  end

end
