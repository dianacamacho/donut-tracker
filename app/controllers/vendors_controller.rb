class VendorsController < ApplicationController
  before_action :set_vendor, only: [:edit, :update, :destroy]
  access user: { except: [:new, :create, :edit, :update, :destroy] }, admin: :all

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
      trigger_sms_alerts(@vendor)
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
      params.require(:vendor).permit(:name, :twitter, :hashtag, :opening_time, :address, :email, :image)
    end

    def boot_twilio
      @client =  Twilio::REST::Client.new ENV["TWILIO_ACCOUNT_SID"], ENV["TWILIO_AUTH_TOKEN"]
    end

    def trigger_sms_alerts(vendor)
      @message = "Hey there! New vendor: #{vendor.name}"
      send_message(ENV["PHONE_NUMBER"], @message)
    end

    def send_message(phone_number, alert_message)
      @twilio_number = ENV['TWILIO_NUMBER']
      boot_twilio      
      message = @client.account.messages.create(
        :from => @twilio_number,
        :to => phone_number,
        :body => alert_message,
        # US phone numbers can make use of an image as well.
        # :media_url => image_url 
      )
      puts message.to
    end
end
