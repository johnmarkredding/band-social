class Band < ApplicationRecord
  belongs_to :manager, class_name: 'User', foreign_key: 'manager_id'
  has_many :memberships
  has_many :members, through: :memberships

  validates_presence_of :name
  validates_uniqueness_of :name
  validates_presence_of :description
end
