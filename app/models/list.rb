class List < ActiveRecord::Base
  belongs_to :project
  has_many :todos
end
