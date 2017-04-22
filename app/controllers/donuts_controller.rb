class DonutsController < ApplicationController
  before_action :set_donut, only: [:edit, :update, :destroy]
  before_action :authenticate_user!
  access user: :all
  
  def index
  end

  def new
    @donut = Donut.new(donut_params)
  end

  def create
    @donut = Donut.new(donut_params)

    if @donut.save
      redirect_to donuts_path
    else 
      render :new
    end
  end

  def edit
  end

  def update
    if @donut.update(donut_params)
      redirect_to donuts_path
    else
      render :edit
    end
  end

  def destroy
    @donut.destroy
    redirect_to donuts_path
  end

  private
    def set_donut
      @donut = Donut.find(params[:id])
    end

    def donut_params
      params.require(:donut).permit(:name, :user_id)
    end
end
