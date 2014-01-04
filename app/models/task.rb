class Task < ActiveRecord::Base
  belongs_to :project
  has_many :entries
  has_one :goal

  # attr_accessor :name
end
