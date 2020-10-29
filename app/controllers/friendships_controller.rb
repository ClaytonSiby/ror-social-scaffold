class FriendshipsController < ApplicationController
  def create
    return if current_user.friend_sent.exists?(params[:user_id])

    # @friendship = current_user.friend_sent.build(friend_id: params[:user_id])
    @friendship = current_user.friend_sent.build(friend_id: params[:user_id])

    @friendship.save

    if @friendship
      flash[:notice] = 'Friend Request Sent'
    else
      flash[:alert] = 'Failed to send friend request.'
    end
    redirect_to root_path
  end

  def accept_friend

    # @friendship = Friendship.find_by(user_id: params[:user_id], friend_id: current_user.id, confirmed: false)
    @friendship = Friendship.where(user_id: params[:user_id], friend_id: current_user.id, confirmed: false)
    
    return if @friendship # return if no record is found

    if @friendship.create(confirmed: true)
      flash[:notice] = 'Friend Request Accepted!'
      @friendship_two = current_user.friend_sent.build(friend_id: params[:user_id], confirmed: true)

      @friendship_two.save
    else
      flash[:alert] = 'Friend Request could not be accepted!'
    end
    redirect_to root_path
  end

  def decline_friend
    @friendship = Friendship.find_by(user_id: params[:user_id], friend_id: current_user.id, confirmed: false)

    return unless @friendship

    @friendship.destroy
    flash[:notice] = 'Friend Request Declined!'
    
    redirect_to root_path
  end
end
