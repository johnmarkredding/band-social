class BandsController < ApplicationController
  before_action :set_requested_band, only: [:show, :edit, :update, :destroy]

  def index
    @bands = Band.all
  end

  def new
    @new_band = Band.new
  end

  def create
    params[:band][:manager_id] = @logged_in_user.id
    @new_band = Band.new(band_params)
    if @new_band.save
      redirect_to band_path(@new_band)
    else
      flash.now[:errors] = @new_band.errors.full_messages
      render :new
    end
  end

  def show
    # @members = @requested_band.members
      @members = ["1", "2", "3"]
  end

  def edit
  end

  def update
    if @requested_band.update(band_params)
      redirect_to band_path(@requested_band)
    else
      flash.now[:errors] = ["None Unique Name"]
      render :edit
    end
  end

  def destroy
    @requested_band.destroy
    redirect_to home_path
  end


  private

  def set_requested_band
    @requested_band = Band.find(params[:id])
  end

  def band_params
    params.require(:band).permit(:name, :description, :manager_id)
  end
end
