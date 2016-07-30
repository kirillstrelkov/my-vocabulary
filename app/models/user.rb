class User < ActiveRecord::Base
  has_many :words
  validates :name, :email, presence: true
end
