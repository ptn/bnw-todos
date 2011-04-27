class Todo < ActiveRecord::Base
  belongs_to :list
  has_one :assignee, :class_name => "User"
end
