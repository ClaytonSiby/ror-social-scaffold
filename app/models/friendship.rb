class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: 'User'

  scope :friends, -> { where(confirmed: true) }
  scope :non_friends, -> { where(confirmed: false) }
end
