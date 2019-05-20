class Task < ApplicationRecord
  validates :title, presence: true, length: { maximum: 50 }
  validates :content, presence: true, length: { maximum: 140 }
  validates :priority, presence: true
  validates :status, presence: true
  validates :deadline, presence: true
end
