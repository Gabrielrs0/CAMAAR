class Template < ApplicationRecord
  has_many :questions
  has_one  :form

  validates :title, presence: true
end
