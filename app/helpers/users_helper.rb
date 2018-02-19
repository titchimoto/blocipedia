module UsersHelper

  def user_is_premium
    current_user && (current_user.premium? || current_user.admin?)
  end

  def user_is_standard
    current_user && current_user.standard?
  end

end
