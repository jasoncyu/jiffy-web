require 'csv'
module ApplicationHelper
  JIFFY_CSV_PATH = '/Users/yujason2/Dropbox/jiffy.csv'


  def javascript(*files)
    content_for(:head) { javascript_include_tag(*files) }
  end

end
