class FriendshipsController < ApplicationController
  def create
    return if current_user.friend_sent.exists?(params[:user_id], confirmed: false)
    
    @friendship = current_user.friend_sent.build(friend_id: params[:user_id])

    if @friendship.save
      flash[:notice] = 'Friend Request Sent'
    else
      flash[:alert] = 'Failed to send friend request.'
    end
    redirect_to root_path
  end
end
