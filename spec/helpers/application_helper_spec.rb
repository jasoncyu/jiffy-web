require 'spec_helper'

# Specs in this file have access to a helper object that includes
# the ApplicationHelper. For example:
#
# describe ApplicationHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
describe ApplicationHelper do
  subject {helper}

  describe "should exist" do
    it {should respond_to(:javascript)}
    it {should respond_to(:parse_entries)}
  end

  describe "parse_entries" do
    it "shouldn't increment Entry count when reading in duplicate files" do
      helper.parse_entries '/Users/yujason2/Dropbox/Apps/JiffyBackup/jiffy.csv'
      old_count = Entry.count
      helper.parse_entries '/Users/yujason2/Dropbox/Apps/JiffyBackup/jiffy.csv'
      new_count = Entry.count

      expect(old_count).to eq(new_count)
    end
  end

end
