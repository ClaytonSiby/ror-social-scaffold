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

    if current_user.confirm_friendship(friend)
      flash[:notice] = "#{friend.name} is now a friend!"
    else
      flash[:notice] = 'Failed to accept friend request'
    end

    redirect_to users_path
  end

  def destroy_friendship
    friend = User.find(params[:id])

    friendship = Friendship.find do |friendship|
      (friendship.user_id == current_user.id && friendship.friend_id == friend.id) ||
      (friendship.user_id == friend.id && friendship.friend_id == current_user.id)
    end

    friendship&.destroy

    flash[:notice] = "Request cancelled or #{friend.name} is no longer a friend!"
    redirect_to users_path
  end
end
