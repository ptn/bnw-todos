require 'digest/sha1'

class User < ActiveRecord::Base
  attr_accessor :password_confirmation
  validates :password, :confirmation => true
  validates_presence_of :username

  has_many :participants
  has_many :projects, :through => :participants

  def password
    @password
  end

  def password=(pwd)
    @password = pwd
    return if pwd.blank?
    create_salt
    self.hashed_password = User.encrypt_password self.password, self.salt
  end


  private

  def self.encrypt_password(pwd, salt)
    Digest::SHA1.hexdigest(pwd + salt)
  end

  def create_salt
    self.salt = self.object_id.to_s + rand.to_s
  end
end

# == Schema Information
#
# Table name: users
#
#  id              :integer         not null, primary key
#  username        :string(255)
#  hashed_password :string(255)
#  salt            :string(255)
#  created_at      :datetime
#  updated_at      :datetime
#