class Todo < ActiveRecord::Base
  scope :due_today, lambda { where("due_date = ?", Date.today) }
  scope :overdue, lambda { where("due_date < ?", Date.today) }

  belongs_to :list
  has_one :assignee, :class_name => "Participant"

  validates_presence_of :task

  def due_today?
    self.due_date == Date.today
  end

  def overdue?
    self.due_date < Date.today
  end
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
