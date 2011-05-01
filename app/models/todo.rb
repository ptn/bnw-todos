class Todo < ActiveRecord::Base
  scope :due_today, lambda { where("due_date = ?", Date.today) }
  scope :overdue, lambda { where("due_date < ?", Date.today) }
  scope :left, where(:done => false)
  scope :done, where(:done => true)
  # scope :due_soon

  belongs_to :list
  delegate :project, :to => :list
  belongs_to :assignee, :class_name => "Participant"
  delegate :user, :to => :assignee

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
