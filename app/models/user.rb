class User < ActiveRecord::Base
  attr_accessor :report
  mount_uploader :report, ReportUploader
end
