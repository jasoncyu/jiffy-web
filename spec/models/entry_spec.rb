require 'spec_helper'
require 'application_helper'

describe Entry do
  before(:each) do
    @entry = Entry.new(start_time: DateTime.new(2014, 1, 1, 15, 30))
    @short_entry = Entry.new(start_time: Time.utc(2014,4,1,15,30), stop_time: Time.utc(2014,4,1,15,0), hours: 0, minutes: 30)
  end

  subject {@entry}

  describe "when entry has already been added" do
    before do
      @dup_entry = @entry.dup
      @dup_entry.save
    end

    it {should_not be_valid}
  end

  describe "duration method" do
    it "should work for numbers less than 1" do 
      @short_entry.duration.should == 0.5
    end
  end

  describe "methods for entries across weeks" do
    before(:each) do 
      @week = Week.new(start_day: Date.new(2014,3,24))
      @next_week = Week.new(start_day: @week.start_day + 7.days)
      @one_day_entry = Entry.new(start_time: Time.utc(2014,3,24,9), stop_time: Time.utc(2014,3,24,10), hours: 1, minutes: 0)
      start_time = Time.utc(2014,3,24,17,30)
      stop_time = Time.utc(2014,3,25,2,30)
      @split_entry = Entry.new(start_time: start_time, stop_time: stop_time, hours: 9)
      @two_weeks_entry = Entry.new(start_time: Time.utc(2014,3,30,21,30), stop_time: Time.utc(2014,3,31,1), hours: 3, minutes: 30)
    end

    describe "spans_two_days? method" do
      it "should detect entries that span two days" do
        @split_entry.spans_two_days?.should == true

        date = Date.today()
        @single_entry = Entry.new(start_time: date, stop_time: date) 
        @single_entry.spans_two_days?.should == false
      end
    end

    describe "tomorrow method" do
      it "should generate a tomorrow at midnight" do 
        @split_entry.tomorrow.should == Time.utc(2014,3,25,0,0)
      end
    end

    describe "split_duration method" do
      it "split_duration should if it spans two days" do
        duration_today = @split_entry.split_duration[0]
        duration_tomorrow = @split_entry.split_duration[1]

        duration_today.should == 6.5
        duration_tomorrow.should == 2.5
      end
    end

    describe "duration_for_week method" do
      it "should work if it spans two days in one week" do
        @split_entry.duration_for_week(@week).should == 9
      end

      it "regular entry during a single day" do
        @one_day_entry.duration_for_week(@week).should == 1
      end

      it "should work if it spans two weeks" do
        @two_weeks_entry.duration_for_week(@week).should == 2.5
        @two_weeks_entry.duration_for_week(@next_week).should == 1      
      end
    end

    it "should give the proper duration if it spans a single week" do
      monday = Time.utc(2014,3,31)
      week = Week.new start_day: monday

      @short_entry.spans_two_days?.should == false
      @short_entry.duration_for_week(week).should == 0.5
    end


    # describe "starts in week" do
    #   @split_entry = Entry.new(start_time: start_time, stop_time: stop_time)
      
    # end
  end
end
