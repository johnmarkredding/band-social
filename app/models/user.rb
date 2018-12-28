class User < ApplicationRecord
  has_many :bands, foreign_key: 'manager_id'

  validates_presence_of :name
  validates_presence_of :password_digest
  validates_presence_of :username
  validates_uniqueness_of :username

  has_secure_password

  def admin?
    self.role == "admin"
  end
end
