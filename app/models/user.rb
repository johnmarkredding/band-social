class User < ApplicationRecord
  has_many :managed_bands, class_name: "Band", foreign_key: 'manager_id', dependent: :destroy
  has_many :memberships, foreign_key: 'member_id', dependent: :destroy
  has_many :bands, through: :memberships
  has_many :conversations, dependent: :destroy, foreign_key: 'sender_id'
  has_many :conversations, dependent: :destroy, foreign_key: 'sender_id'
  has_many :posts, dependent: :destroy

  validates_presence_of :name
  validates_presence_of :password_digest
  validates_presence_of :username
  validates_uniqueness_of :username

  has_secure_password

  def admin?
    self.role == "admin"
  end

  def full_handle
    "#{self.name} | @#{self.username}"
  end

  def handle
    "@#{self.username}"
  end
end
