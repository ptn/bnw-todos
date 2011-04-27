class Participant < ActiveRecord::Base
  belongs_to :project
  belongs_to :user
  has_many :todos, :foregin_key => "assignee_id"
  delegate :username, :to => :user
end
