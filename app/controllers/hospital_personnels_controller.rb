class HospitalPersonnelsController < ApplicationController
  # проверяет может ли текущий юзер редактировать персонал больницы
  before_action :user_can_edit?, expect: [:show, :index]
  before_action :set_cu_hospital_personnel, only: [:edit, :update, :destroy]

  def index

  end

  def new
    @hospital_personnel = HospitalPersonnel.build
  end

  def edit

  end

  def show
  end

  def update
    if @hospital_personnel.update(hospital_personnel_params)
      redirect_to hospital_path(id: @hospital_personnel.hospital_id), notice: '1'
    else
      render :new
    end
  end

  def destroy
    @hospital_personnel.destroy
    redirect_to hospital_path(id: @hospital_personnel.hospital_id), notice: '1'
  end

  private

  def set_cu_hospital_personnel
    @hospital_personnel = HospitalPersonnel.find(params[:id])
  end

  def hospital_personnel_params
    params.require(:hospital_personnel).permit(:surname, :year_of_birth, :position)
  end

  def user_can_edit?
    @hospital = Hospital.find(params[:id])
    redirect_to hospital_path, alert: '0' unless user_signed_in?

    if user_signed_in?
      redirect_to hospital_path, alert: '0' unless current_user.hospitals.find_by(id: @hospital.id)
    end
  end

end
