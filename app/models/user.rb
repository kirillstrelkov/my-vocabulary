class User < ActiveRecord::Base
  has_many :words
  validates :name, :email, presence: true
  validates :email, uniqueness: true
end
