class Hospital < ApplicationRecord
  belongs_to :user
  has_many :hospital_personnels

  validates :user, presence: true
  validates :phone, presence: true, length: {in: 2..13}
  validates :phone, uniqueness: true
end
