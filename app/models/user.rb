class User < ApplicationRecord
  validates :email, presence: true
  validates :password, presence: true, uniqueness: true
  validates :api_key, presence: true, uniqueness: true
end