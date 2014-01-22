class UsersController < ApplicationController
  def show
    @user = User.friendly.find(params[:id])
    @listings = @user.listings
  end
end

