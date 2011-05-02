class List < ActiveRecord::Base
  scope :done, where(:done => true)
  scope :left, where(:done => false)

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
