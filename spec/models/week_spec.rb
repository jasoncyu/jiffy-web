require 'spec_helper'

describe Week do
  describe "day method" do
    before do
      @week = Week.new start_day: Date.parse("March 31, 2014") 
      @days = (0..6).map{|i| @week.start_day + i.days}
    end

    it "should include days in the week" do
      @days.each do |day|
        @week.contains_day?(day).should == true
      end
    end
  end
end
