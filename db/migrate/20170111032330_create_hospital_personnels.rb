class CreateHospitalPersonnels < ActiveRecord::Migration[5.0]
  def change
    create_table :hospital_personnels do |t|
      t.string :surname
      t.date :year_of_birth
      t.string :position
      # сотрудник больницы принадлежит больнице и себе (personnel) :)
      t.references :personnel, index: true, foreign_key: true, null: false
      t.references :hospital, index: true, foreign_key: true, null: false

      t.timestamps
    end
  end
end
