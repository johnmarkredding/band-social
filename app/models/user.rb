class User < ApplicationRecord
  has_many :managed_bands, class_name: "Band", foreign_key: 'manager_id'
  has_many :memberships
  has_many :bands, through: :memberships, class_name: 'User', foreign_key: 'member_id'

  validates_presence_of :name
  validates_presence_of :password_digest
  validates_presence_of :username
  validates_uniqueness_of :username

  has_secure_password

  def admin?
    self.role == "admin"
  end

end
