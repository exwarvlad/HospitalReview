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
      redirect_to @hospital, notice: I18n.t('controllers.hospitals.created')
    else
      render :new, alert: I18n.t('controllers.hospitals.created_error')
    end
  end

  def show

  end

  def destroy
    # чищу за собой концы, перед сносом больницы
    @hospital.hospital_personnels.all.each {|personnel| personnel.destroy}
    @hospital.destroy
    redirect_to root_path, alert: I18n.t('controllers.hospitals.destroyed')
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
