class List < ActiveRecord::Base
  scope :done, where(:done => true)
  scope :left, where(:done => false)
  #FIXME Should return an ActiveRecord Relation
  scope :from_project_where_user_participates, lambda { |project, user|
    participant = Participant.where(:user_id => user.id, :project_id => project.id).first
    lists = nil
    if participant
      lists = project.lists.select { |list| list.todos.any? { |todo| todo.assignee == participant } }
    end
    lists
  }


  belongs_to :project
  has_many :todos, :dependent => :destroy

  validates_presence_of :title
end

# == Schema Information
#
# Table name: lists
#
#  id         :integer         not null, primary key
#  project_id :integer
#  title      :string(255)
#  created_at :datetime
#  updated_at :datetime
#
