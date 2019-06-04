class Task < ApplicationRecord
  belongs_to :user

  validates :title, presence: true, length: { maximum: 50 }
  validates :content, presence: true, length: { maximum: 140 }
  validates :priority, presence: true
  validates :status, presence: true
  validates :deadline, presence: true

  scope :search_title, -> (title) { where("title LIKE ?", "%#{ title }%") }
  scope :search_status, -> (status) { where("status LIKE ?", "%#{ status }%") }
  # 2つまとめたのを作ろうとしたが上手くいかない
  # scope :search_title_status, -> (title, status) { where("title LIKE ?", "%#{ title }%").("status LIKE ?", "%#{ status }%") }

  enum priority:{ 低:0, 中:1, 高:2 }
end
