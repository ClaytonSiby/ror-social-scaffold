module UsersHelper
  def non_friend_and_not_current_user?(user)
    user != current_user && !current_user.friends.include?(user)
  end

  def non_friend?(user)
    !current_user.friends.include?(user) && !current_user.friend_sent.include?(user)
  end
end