class HospitalPersonnel < ApplicationRecord
  belongs_to :hospital

  # validates :personnel_id, uniqueness: true
end
