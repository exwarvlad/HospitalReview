class PersonnelsController < ApplicationController
  before_action :authenticate_user!, only: [:new]
  before_action :set_personnel, only: [:show]
  before_action :set_current_user_personnel, only: [:edit, :update, :destroy]

  def index
    @personnels = Personnel.all
  end

  def show

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

end
