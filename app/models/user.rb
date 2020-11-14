# frozen_string_literal: true

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  devise :omniauthable, omniauth_providers: %i[facebook vkontakte google]
  has_many :words
  validates :name, :email, presence: true
  validates :email, uniqueness: true

  def self.from_omniauth(auth)
    User.where(
      provider: auth.provider,
      uid: auth.uid
    ).first_or_create! do |user|
      user.name = auth.info.name
      new_email = "#{auth.uid}@#{auth.provider}".downcase
      user.email = auth.info.email || new_email
      user.password = Devise.friendly_token[0, 20]
    end
  end
end
