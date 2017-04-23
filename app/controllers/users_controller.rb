class UsersController < ApplicationController

  def show
  end

  private

    def authorize_user
      @user = User.find(params[:id])
      if @user != current_user
        flash[:warning] = "You do not have access to that page!"
        redirect_to vendors_path
      end
    end
end
