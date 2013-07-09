class Users::RegistrationsController < Devise::RegistrationsController
  layout 'application_users_new'
  def create
    build_resource
    @errors =[]
    if  client_signed_in?
      @errors << 'You are already loggedin as a client, please signout and try again.'
    elsif portal_user_signed_in?
      @errors << 'You are already loggedin as Admin, please signout and try again.'
    else
      if resource.save
        if resource.active_for_authentication?
          set_flash_message :notice, :signed_up if is_navigational_format?
          sign_up(resource_name, resource)
          #  respond_with resource, :location => after_sign_up_path_for(resource)
          flash[:success] = "A message with a confirmation link has been sent to your email address. Please open the link to activate your account."
        else
          set_flash_message :notice, :"signed_up_but_#{resource.inactive_message}" if is_navigational_format?
          expire_session_data_after_sign_in!
          # respond_with resource, :location => after_inactive_sign_up_path_for(resource)
        end
      else

        resource.errors.full_messages.each do |msg|
          @errors << msg
        end
      end
    end
    respond_to :js
  end
end