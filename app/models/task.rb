class Task < ActiveRecord::Base
  belongs_to :project
  has_many :entries
end
