class Project < ActiveRecord::Base
  has_many :lists

  validates_presence_of :name
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
