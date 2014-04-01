require 'spec_helper'
require 'application_helper'

describe Entry do
  before do
    @entry = Entry.new(start_time: DateTime.new(2014, 1, 1, 15, 30))
  end

  subject {@entry}

  describe "when entry has already been added" do
    before do
      @dup_entry = @entry.dup
      @dup_entry.save
    end

    it {should_not be_valid}
  end

end
