class FriendshipsController < ApplicationController
  def create
    @friendship = Friendship.new(friendship_params)

    if @friendship.save
      flash[:notice] = 'Friends request sent!'
    else
      flash[:alert] = 'Could not send friendship request'
    end

    redirect_to users_path
  end

  def accept_friendship
    friend = User.find(params[:id])

    if current_user.confirm_friendship(friend)
      flash[:notice] = "You are now friends with #{friend.name}"
    else
      flash[:alert] = 'Failed to accept friendship'
    end

    redirect_to users_path
  end

  def decline_friendship
    friend = User.find(params[:id])

    @friendship = Friendship.find_by(friend_id: friend.id, user_id: current_user.id)

    @friendship.destroy

    @friendship_inverse = Friendship.find_by(friend_id: current_user.id, user_id: friend.id)

    @friendship_inverse.destroy

    flash[:notice] = 'Friend request declined!'

    redirect_to users_path
  end

  private

  def friendship_params
    params.require(:friendship).permit(:user_id, :friend_id)
  end
end
