class Project < ActiveRecord::Base
  has_many :tasks
  has_many :entries
  has_one :goal

  # attr_accessor :name
end
