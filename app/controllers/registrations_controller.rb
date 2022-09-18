class RegistrationsController < Devise::RegistrationsController


    
    protected
  

    def configure_sign_up_params
      params.require(:user).permit(:email, :password, :password_confirmation, :atatar, :admin, :skip_password_validation)
  end

  end