class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, length: { maximum: 20 }

  has_many :posts
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  has_many :friendships

  has_many :inverse_friendships, class_name: 'Friendship', foreign_key: 'friend_id'

  def friends
    friends_list = friendships.map { |friendship| friendship.friend if friendship.confirmed }

    friends_list += inverse_friendships.map { |friendship| friendship.user if friendship.confirmed }

    friends_list.compact
  end

  def pending_requests
    friendships.map { |friendship| friendship.friend if !friendship.confirmed }.compact
  end

  def friendship_requests
    inverse_friendships.map { |friendship| friendship.user if !friendship.confirmed }.compact
  end

  def confirm_friendship(user)
    friendship_record = inverse_friendships.find { |friendship| friendship.user == user }
    friendship_record.confirmed = true
    friendship_record.save
  end

  def friend?(user)
    friends.include?(user)
  end
end
