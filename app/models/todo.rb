class Todo < ActiveRecord::Base
  belongs_to :list
  has_one :assignee, :class_name => "User"

  validates_presence_of :task
end

# == Schema Information
#
# Table name: todos
#
#  id          :integer         not null, primary key
#  task        :string(255)
#  due_date    :date
#  assignee_id :integer
#  list_id     :integer
#  created_at  :datetime
#  updated_at  :datetime
#
