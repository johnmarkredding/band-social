class Band < ApplicationRecord
  belongs_to :manager, class_name: 'User', foreign_key: 'manager_id'
  has_many :memberships, dependent: :destroy
  has_many :members, through: :memberships

  validates_presence_of :name
  validates_uniqueness_of :name
  validates_presence_of :description

  def get_roles_string(user)
    roles = []
    if self.manager == user
      roles << 'Manager'
    end
    if self.members.include?(user)
      roles << 'Member'
    end
    roles.join(', ')
  end

  def posts
    posts = self.members.map do |member|
      member.posts
    end
    posts << self.manager.posts
    posts.flatten.uniq.sort_by {|post| post.created_at}.reverse
  end
end
