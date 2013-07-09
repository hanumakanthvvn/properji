class Users::SessionsController < Devise::SessionsController
  layout 'application_users_new'

  def create
    puts"########################################",params[:mode]
    if client_signed_in?
      @errors = ['You are already loggedin as a client, please signout and try again.']
    elsif portal_user_signed_in?
      @errors = ['You are already loggedin as Admin, please signout and try again.']
    else
      @email = params[:user][:email]
      @user = User.find_by_email(@email)
      if @email.present? && @user.present? && @user.valid_password?(params[:user][:password]) && @user.confirmed? && @user.approved
        resource = warden.authenticate!(auth_options)
        set_flash_message(:notice, :signed_in) if is_navigational_format?
        sign_in(resource_name, resource)
        # respond_with resource, :location => after_sign_in_path_for(resource)
      elsif @email.present? && @user.present? && (@user.confirmed?.eql?(false))
        @errors = ["You have to confirm your account before continuing"]
      elsif @email.present? && @user.present? && @user.approved.eql?(false)
        @errors = ["Your account has been suspended. Please contact administrator for further access. "]
      else
        @errors = ["Invalid email or password"]
      end
    end
    respond_to :js
  end

  def destroy
    redirect_path = root_path
    signed_out = (Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name))
    set_flash_message :notice, :signed_out if signed_out

    # We actually need to hardcode this as Rails default responder doesn't
    # support returning empty response on GET request
    respond_to do |format|
      format.any(*navigational_formats) { redirect_to redirect_path }
      format.all do
        head :no_content
      end
    end
  end
end
