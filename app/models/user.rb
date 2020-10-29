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

  has_many :requested_friendships, -> { where(confirmed: false) }, class_name: 'Friendship'
  has_many :received_requests, -> { where(confirmed: false) }, class_name: 'Friendship', foreign_key: 'friend_id'
  
  has_many :friends, -> { where(confirmed: true) }, class_name: 'Friendship'
  has_many :pending_friends, through: :requested_friendships, source: :friend
  has_many :friendship_requests, through: :received_friendships, source: :user

  def confirm_friendship(user)
    friend_record = received_requests.find_by(user_id: user.id)
    friendship_record.confirmed = true
    friend_record.save

    Friendship.create(user_id: id, friend_id: user.id, confirmed: true)
  end

  def friend?(user)
    friends.include?(user)
  end
end
