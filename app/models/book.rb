class Book < ApplicationRecord
  belongs_to :author

  validates :title, presence: true, uniqueness: { case_sensitive: true }

  validates :published_date, presence: true
end
