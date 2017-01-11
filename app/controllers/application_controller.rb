class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :current_user_can_edit?

  def current_user_can_edit?(model)
    user_signed_in? &&
        (model.user == current_user || # если у модели есть юзер и он залогиненный
            # пробуем у модели взять .personnel и если он есть, проверяем его юзера
            (model.try(:personnel).present? && model.personnel.user == current_user))
  end
end
