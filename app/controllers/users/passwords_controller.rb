class Users::PasswordsController < Devise::PasswordsController
  layout 'application_users_new'

  def create
    self.resource = resource_class.send_reset_password_instructions(resource_params)
    @errors =[]

    if successfully_sent?(resource)
      #respond_with({}, :location => after_sending_reset_password_instructions_path_for(resource_name))
     # redirect_to root_path
      #flash[:susscess]="You will receive an email with instructions about how to reset your password in a few minutes."
    else
      resource.errors.full_messages.each do |msg|
        @errors << msg
      end
    end
    respond_to :js

  end

   # PUT /resource/password
  def update
    @errors =[]
    self.resource = resource_class.reset_password_by_token(resource_params)

    if resource.errors.empty?
      flash_message = resource.active_for_authentication? ? :updated : :updated_not_active
      set_flash_message(:notice, flash_message) if is_navigational_format?
      sign_in(resource_name, resource)
      #redirect_to clients_dashboard_index_path
      # respond_with resource, :location => after_sign_in_path_for(resource)
    else
      resource.errors.full_messages.each do |msg|
        @errors << msg
      end
    end
    respond_to :js
  end
end