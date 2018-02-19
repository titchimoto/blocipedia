class RegistrationsController < Devise::RegistrationsController

  protected

    def update_resource(resource, params)
      if params[:password].blank? && params[:password_confirmation].blank?
      resource.update_without_password(params)
    else
     super
    end
  end

  def sign_up_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :role)
  end

  def account_update_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :current_password, :role)
  end
    
end
