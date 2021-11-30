class Book < ApplicationRecord
  belongs_to :author

  validates :title, presence: true, uniqueness: true

  validates :author, presence: true

  validates :published_date, presence: true
end
