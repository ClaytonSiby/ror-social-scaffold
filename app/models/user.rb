class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, length: { maximum: 20 }

  has_many :posts
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  has_many :friendships, dependent: :destroy

  has_many :friend_sent, class_name: 'Friendship',
                         foreign_key: 'user_id',
                         inverse_of: 'user',
                         dependent: :destroy

  has_many :friend_requests, class_name: 'Friendship',
                             foreign_key: 'friend_id',
                             inverse_of: 'friend',
                             dependent: :destroy

  has_many :friends, -> { merge(Friendship.friends) },
            through: :friend_sent, source: 'friend'

  has_many :pending_requests, -> { merge(Friendship.non_friends) },
            through: :friend_sent, source: 'friend'

  has_many :received_requests, -> { merge(Friendship.non_friends) },
           through: :friend_requests, source: 'user'
end
