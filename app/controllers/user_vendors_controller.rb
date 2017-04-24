class UserVendorsController < ApplicationController
  before_action :set_user_vendor, only: [:destroy]
  access user: :all
  
  def index
    @user_vendor = UserVendor.new
    @user_vendors = current_user.user_vendors
    @vendors = Vendor.all
    puts "*" * 100
    p @images
  end

  def create
    @user_vendor = UserVendor.new(user_vendor_params)
    @user_vendor.user_id = current_user.id

    if @user_vendor.save
      redirect_to my_shops_path
    else 
      redirect_to my_shops_path
    end
  end

  def destroy
    @user_vendor.destroy
    redirect_to my_shops_path
  end

  private
    def set_user_vendor
      @user_vendor = UserVendor.find(params[:id])
    end

    def user_vendor_params
      params.require(:user_vendor).permit(:vendor_id)
    end
end
