module UsersHelper
  def non_friend_and_not_current_user?(user)
    user != current_user && non_friend?(user) && !in_friend_request?(user) && !in_pending_request?(user)
  end

  def non_friend?(user)
    !current_user.friends.include?(user)
  end

  def in_pending_request?(user)
    current_user.pending_requests.include?(user)
  end

  def in_friend_request?(user)
    current_user.friendship_requests.include?(user)
  end

  def determine_friendship(user)
    if in_pending_request?(user)
      link_to 'Cancel Request', destroy_friendship_path(user.id), class: 'text-light'
    elsif in_friend_request?(user)
      link_to 'Decline Request', destroy_friendship_path(user.id), class: 'text-light'
    elsif current_user.friend?(user)
      link_to 'Unfriend', destroy_friendship_path(user.id), class: 'text-light'
    end
  end
end
