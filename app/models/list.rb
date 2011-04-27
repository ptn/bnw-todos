class List < ActiveRecord::Base
  belongs_to :project
  has_many :todos

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
