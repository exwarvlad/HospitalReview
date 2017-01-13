class HospitalPersonnelsController < ApplicationController
  before_action :set_cu_hospital_personnel, only: [:edit, :update, :destroy]

  def index
    @hospital = Hospital.find(params[:hospital_id])
    # проверка может ли юзер просматривать список доступного персонала для добавления
    redirect_to root_path, alert: 'Вам туда низя' unless can_user_add_personnel?(@hospital)
    @new_personnels = get_personnels_list(@hospital)
  end

  def edit
    # проверяет может ли текущий юзер редактировать персонал больницы
    unless_user_can_edit?
  end

  def create
    @hospital = Hospital.find(params[:id])
    # проверяет может ли текущий юзер добавить персонал для больницы
    return redirect_to root_path, alert: 'Вам туда низя' unless can_user_add_personnel?(@hospital)
    @hospital.hospital_personnels.create(
        personnel_id: params[:personnel_id], surname: params[:surname],
        year_of_birth: params[:year_of_birth], position: params[:position]
    )
    redirect_to hospital_path(@hospital), notice: "#{@hospital.id}"
  end

  def update
    # проверяю может ли текущий пользователь обновлять больницу
    return redirect_to root_path, alert: 'Вам туда низя' unless can_user_add_personnel?(get_hospital)
    if @hospital_personnel.update(hospital_personnel_params)
      redirect_to hospital_path(id: @hospital_personnel.hospital_id), notice: '1'
    else
      redirect_to hospital_path(@hospital), notice: "---"
    end
  end

  def destroy
    # проверяю может ли текущий юзер удалять сотрудника больницы
    return redirect_to root_path, alert: 'Вам туда низя' unless can_user_add_personnel?(get_hospital)
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

  def unless_user_can_edit?
    return redirect_to root_path, alert: '0' unless user_signed_in?
    if user_signed_in?
      hospital = HospitalPersonnel.find(params[:id])
      hospital_id = hospital.hospital_id
      hospital_user = Hospital.find_by(id: hospital_id).user
      redirect_to root_path, alert: '0' unless current_user == hospital_user
    end
  end

  # возвращает спиок персонала, который можно нанять
  def get_personnels_list(hospital)
    arra = []
    personnels_id_array = hospital.hospital_personnels.all.map(&:personnel_id)

    Personnel.all.each do |person|
      arra << person unless personnels_id_array.include?(person.id)
    end
    arra
  end

  # может ли текущий юзер редаетировать больницу
  def can_user_add_personnel?(hospital)
    return false unless user_signed_in?
    return false unless current_user == hospital.user
    true
  end

  # возвращает @hospital для фильтров в update и destroy
  def get_hospital
    hospital = HospitalPersonnel.find(params[:id])
    hospital_id = hospital.hospital_id
    @hospital = Hospital.find_by(id: hospital_id)
  end
end
