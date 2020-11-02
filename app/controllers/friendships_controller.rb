class FriendshipsController < ApplicationController
  def send_request
    friend = User.find(params[:id])

    @friendship = Friendship.new(user_id: current_user.id, friend_id: friend.id)

    if @friendship.save
      flash[:notice] = 'Friend request sent!'
    else
      flash[:alert] = 'Failed to send friend request'
    end
    redirect_to users_path
  end

  def accept_friend
    friend = User.find(params[:id])

    flash[:notice] = if current_user.confirm_friendship(friend)
                       "#{friend.name} is now a friend!"
                     else
                       'Failed to accept friend request'
                     end

    redirect_to users_path
  end

  def destroy_friendship
    friend = User.find(params[:id])

    friendship = Friendship.find do |frendship|
      (frendship.user_id == current_user.id && frendship.friend_id == friend.id) ||
        (frendship.user_id == friend.id && frendship.friend_id == current_user.id)
    end

    friendship&.destroy

    flash[:notice] = "Request cancelled or #{friend.name} is no longer a friend!"
    redirect_to users_path
  end
end
