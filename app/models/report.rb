class Report < ActiveRecord::Base
  attr_accessor :name
  validates :name, presence: true
end