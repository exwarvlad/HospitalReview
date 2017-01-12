class Hospital < ApplicationRecord
  belongs_to :user
  has_many :hospital_personnels
end
