class ChangeColumnYearOfBirthToPersonnel < ActiveRecord::Migration[5.0]
  def change
    change_column :personnels, :year_of_birth, :integer
    change_column :hospital_personnels, :year_of_birth, :integer
  end
end
