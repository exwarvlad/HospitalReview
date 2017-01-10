class HospitalsController < ApplicationController
  before_action :authenticate_user!, only: [:new]
  before_action :set_hospital, only: [:show]
  before_action :set_current_user_hospital, only: [:destroy]

  def index
    @hospitals = Hospital.all
  end

  def new
    @hospital = current_user.hospitals.build
  end

  def create
    @hospital = current_user.hospitals.build(hospital_params)

    if @hospital.save
      redirect_to @hospital, notice: '1'
    else
      render :new
    end
  end

  def show

  end

  def destroy
    @hospital.destroy
    redirect_to root_path, alert: '1'
  end

  private

  def hospital_params
    params.require(:hospital).permit(:phone)
  end

  def set_hospital
    @hospital = Hospital.find(params[:id])
  end

  def set_current_user_hospital
    @hospital = current_user.hospitals.find(params[:id])
  end

end
