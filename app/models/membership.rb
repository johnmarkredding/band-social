class Membership < ApplicationRecord
  belongs_to :member, class_name: 'User', foreign_key: 'member_id'
  belongs_to :band
end
