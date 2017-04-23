class VendorsController < ApplicationController
  before_action :set_vendor, only: [:edit, :update, :destroy]
  before_action :authenticate_user!

  def index
    @vendors = Vendor.all
    @user_vendor = UserVendor.new
  end

  def new
    @vendor = Vendor.new()
  end

  def create
    @vendor = Vendor.new(vendor_params)

    if @vendor.save
      redirect_to vendors_path
    else 
      render :new
    end
  end

  def edit
  end

  def update
    if @vendor.update(vendor_params)
      flash[:success] = "Vendor updated!"
      redirect_to vendors_path
    else
      render :edit
    end
  end

  def destroy
    @vendor.destroy
    redirect_to vendors_path
  end

  private
    def set_vendor
      @vendor = Vendor.find(params[:id])
    end

    def vendor_params
      params.require(:vendor).permit(:name, :twitter, :hashtag, :time, :opening_time, :image)
    end
end
