class Personnel < ApplicationRecord
  belongs_to :user
  has_many :hospital_personnels

  POSITIONS = [
      "Врач",
      "Медсестра",
      "Фельдшер"
  ]

  validates :surname, presence: true, length: {in: 2..16}
  validates :position, presence: true, inclusion: {in: POSITIONS, message: "Должность имеет недопустимое значение"}
  validates :year_of_birth, presence: true, inclusion: {in: ((Date.today.year - 70)..(Date.today.year - 16)).to_a, message: "Год рождения имеет недопустимое значение"}
end
