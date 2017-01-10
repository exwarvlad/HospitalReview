class CreateHospitals < ActiveRecord::Migration[5.0]
  def change
    create_table :hospitals do |t|
      t.string :phone
      t.references :user, index: true, foreign_key: true

      t.timestamps
    end
  end
end
