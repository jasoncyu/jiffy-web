class User < ActiveRecord::Base
  mount_uploader :report, ReportUploader
end
