class Project < ActiveRecord::Base
  has_many :lists
  has_many :participants
  has_many :users, :through => :participants

  validates_presence_of :name

  def todos
    ids = self.lists.map(&:id).join(", ")
    Todo.where "list_id IN (#{ids})"
  end
end

# == Schema Information
#
# Table name: projects
#
#  id          :integer         not null, primary key
#  name        :string(255)
#  description :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#
