class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.all
    @friends = current_user.friends
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.ordered_by_most_recent
    @mutual_friends = current_user.mutual_friends(@user)
  end

  def user_friends
    @user = User.find(params[:id])
    @friends = @user.friends
  end
end
