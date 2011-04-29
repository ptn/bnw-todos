class Participant < ActiveRecord::Base
  belongs_to :project
  belongs_to :user
  has_many :todos, :foreign_key => "assignee_id"
  delegate :username, :to => :user
end
