class User < ApplicationRecord
  has_many :managed_bands, class_name: "Band", foreign_key: 'manager_id', dependent: :destroy
  has_many :memberships, foreign_key: 'member_id', dependent: :destroy
  has_many :bands, through: :memberships
  has_many :conversations, dependent: :destroy, foreign_key: 'sender_id'
  has_many :posts, dependent: :destroy

  validates_presence_of :name
  validates_presence_of :password_digest
  validates_presence_of :username
  validates_uniqueness_of :username
  validates :password, length: { minimum: 5 }, allow_nil: true

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

  def all_bands
    (self.bands + self.managed_bands).uniq
  end

  def friends
    if !!self.all_bands
      members = []
      self.all_bands.map do |band|
        members += band.members.to_a
        members << band.manager
      end
      members.delete(self)
      members.uniq!
      members
    else
      false
    end
  end
end
