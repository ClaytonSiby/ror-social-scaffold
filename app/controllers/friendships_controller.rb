class FriendshipsController < ApplicationController
  
  def create
    @friendship = current_user.friendships.new(friend_id: params[:user_id], confirmed: false)

    if @friendship.save!
      flash[:notice] = 'Friend request sent!'

    else
      flash[:alert] = 'Couldn\'t send friend request!'
    end

    redirect_to users_path
  end

  def accept_friendship
    @friend = current_user.friendship_requests.find(params[:friend])

    if current_user.confirm_friendship(@friend)
      flash[:notice] = "You're now friends with #{@friend.name}"

    else
      flash[:alert] = 'Failed to accept friend request.'
    end

    redirect_to users_path
  end

  def decline_friendship
    @friendship = current_user.friendship_requests.find(params[:friend])

    if current_user.decline_friend(@friend)
      flash[:notice] = 'Friend request declined successfully!'

    else
      flash[:alert] = 'Failed to decline friend request!'
    end

    redirect_to users_path
  end
end
