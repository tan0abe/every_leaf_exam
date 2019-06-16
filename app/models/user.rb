class User < ApplicationRecord
  has_many :tasks

  validates :name, presence: true, length: { maximum: 30 }
  validates :email, presence: true, length: { maximum: 100 },
            format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
            uniqueness: true
  validates :password_digest, presence: true, length: { minimum: 6 }

  before_validation { email.downcase! }  # メールアドレスを小文字へ変換
  has_secure_password  # gem bcryptを使用しパスワードをハッシュ化
end
