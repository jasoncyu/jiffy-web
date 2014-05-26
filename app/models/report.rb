class Report < ActiveRecord::Base
  attr_accessor :jiffy_summary
  mount_uploader :jiffy_summary, JiffySummaryUploader
end
