class PersonnelsController < ApplicationController
  before_action :authenticate_user!, only: [:new]
  before_action :set_personnel, only: [:show]
  before_action :set_current_user_personnel, only: [:edit, :update, :destroy]

  def index
    @personnels = Personnel.all
  end

  def show
    # список больниц, в которых работает текущий юзер
    @hospitals_list_from_personnel = get_hospitals_list
  end

  def new
    @personnel = current_user.personnels.build
  end

  def create
    @personnel = current_user.personnels.build(personnel_params)
    if @personnel.save
      redirect_to @personnel, notice: '1'
    else
      render :new
    end
  end

  def edit

  end

  def update
    if @personnel.update(personnel_params)
      redirect_to @personnel, notice: '1'
    else
      render :new
    end
  end

  def destroy
    # перед удалением профиля сотрудника, удаляю его концы с других больниц
    clear_personnel_from_hospitals(@personnel)
    @personnel.destroy
    redirect_to personnels_path, notice: '1'
  end

  private

  def set_personnel
    @personnel = Personnel.find(params[:id])
  end

  def set_current_user_personnel
    @personnel = current_user.personnels.find(params[:id])
  end

  def personnel_params
    params.require(:personnel).permit(:surname, :year_of_birth, :position)
  end

  def get_hospitals_list
    arra = []
    # достаю id больниц в которых работает текущий юзер
    hospitals_id = @personnel.hospital_personnels.all.map(&:hospital_id)

    Hospital.all.each do |hosp|
      arra << hosp if hospitals_id.include?(hosp.id)
    end
    arra
  end

  def clear_personnel_from_hospitals(personnel)
    hospitals_id = personnel.hospital_personnels.all.map(&:hospital_id)

    hospitals_id.each do |hosp_id|
      hospital = Hospital.all.find_by(id: hosp_id)
      hospital.hospital_personnels.each {|person| person.destroy if person.personnel_id == personnel.id}
    end
  end

end
