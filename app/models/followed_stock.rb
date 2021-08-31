class FollowedStock < ApplicationRecord
  belongs_to :stock
  belongs_to :user
  validates :stock, uniqueness: { scope: :user }
end
