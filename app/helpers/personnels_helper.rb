module PersonnelsHelper
  def select_helper_personnel_type(array_type)
    arra = []

    array_type.each do |elem|
      new_array = []
      new_array.push(elem, elem)

      arra << new_array
    end
  end

  # возвращает список годов для year_of_birth
  def check_year_list
    ((Date.today.year - 70)..(Date.today.year - 16)).to_a.reverse
  end
end
