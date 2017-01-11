class CreatePersonnels < ActiveRecord::Migration[5.0]
  def change
    create_table :personnels do |t|
      t.string :surname
      t.date :year_of_birth
      t.string :position
      t.references :user, index: true, foreign_key: true

      t.timestamps
    end
  end
end
