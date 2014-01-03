class Task < ActiveRecord::Base
  belongs_to :project
  has_many :entries

  # attr_accessor :name
end
