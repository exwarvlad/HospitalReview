class HospitalPersonnelsController < ApplicationController
  # проверяет может ли текущий юзер редактировать персонал больницы
  before_action :user_can_edit?, expect: [:show, :index]
  before_action :set_cu_hospital_personnel, only: [:edit, :update, :destroy]

  def index

  end

  def new
    @hospital = Hospital.find_by(params[:id])

    @hospital_personnel = Personnel.find_by(params[:id])
    @new_personnels = get_personnels_list
  end

  def edit

  end

  def show
    @personnel = Personnel.find(params[:id])

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

  def add_personnel
    @personnel = Personnel.find(params[:id])
    @hospital = Hospital.find_by(params[:id])

    # посылает, если такой сотрудник уже работает в больнице
    return redirect_to @hospital, alert: 'qwe' unless valid_hospital_personnel?(@personnel, @hospital)

    @hospital.hospital_personnels.create(
        personnel_id: @personnel.id, surname: @personnel.surname, year_of_birth: @personnel.year_of_birth,
        position: @personnel.position
    )
    redirect_to @hospital
  end

  private

  def set_cu_hospital_personnel
    @hospital_personnel = HospitalPersonnel.find(params[:id])
  end

  def hospital_personnel_params
    params.require(:hospital_personnel).permit(:surname, :year_of_birth, :position)
  end

  def user_can_edit?
    @hospital = Hospital.find_by(params[:id])
    redirect_to hospital_path, alert: '0' unless user_signed_in?

    if user_signed_in?
      redirect_to hospital_path, alert: '0' unless current_user.hospitals.find_by(id: @hospital.id)
    end
  end

  def valid_hospital_personnel?(personnel, hospital)
    valid_personnel = true
    hospital.hospital_personnels.each {|elem| valid_personnel = false if elem.personnel_id == personnel.id }
    valid_personnel
  end

  # возвращает спиок персонала, который можно нанять
  def get_personnels_list
    arra = []
    personnels_id_array = @hospital.hospital_personnels.all.map(&:personnel_id)

    Personnel.all.each do |person|
      arra << person unless personnels_id_array.include?(person.id)
    end
    arra
  end
end
