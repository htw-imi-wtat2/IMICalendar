class User::RegistrationsController < Devise::RegistrationsController
  before_action :configure_permitted_parameters, if: :devise_controller?


  # before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
  # def new
  #   super
  # end

  # POST /resource
  # def create
  #   super
  # end

  def show; end

  # GET /resource/edit
  def edit
    @user_ldap_generated = user_ldap_generated
    super
  end

  # PUT /resource
  def update
    if user_ldap_generated
      pw = params[:user][:password]
      pwc = params[:user][:password_confirmation]
      if pw && pwc
        unless resource.update(password: pw, password_confirmation: pwc)
          flash[:alert] = 'Password could not be changed'
        end
      end
    end
    # let devise default implementation handle the rest of the resource update
    super
  end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  protected

  def user_ldap_generated
    resource.ldap_authorized?
  end

  # overwrites update_resource in devise controller
  # does not work for changing passwords as
  # update_without_password deletes the passwords.
  def update_resource(resource, params)
    super unless user_ldap_generated
    resource.update_without_password(params)
  end

  def after_update_path_for(resource)
     edit_user_registration_path
  end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_up_params
  #   devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute])
  # end
  # If you have extra params to permit, append them to the sanitizer.
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:account_update, keys: [:email, :password, :password_confirmation, :first_name, :middle_name, :last_name])
  end

end
