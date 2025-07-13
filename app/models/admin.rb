class Admin < ApplicationRecord
  validates :username, :hash_password, presence: true
  validates :username, uniqueness: true
end
