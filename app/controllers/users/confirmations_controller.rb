class Users::ConfirmationsController < Devise::ConfirmationsController
  layout 'application_users_new'
  def create
    @errors =[]
    self.resource = resource_class.send_confirmation_instructions(resource_params)

    if successfully_sent?(resource)
     # respond_with({}, :location => after_resending_confirmation_instructions_path_for(resource_name))
    else
      resource.errors.full_messages.each do |msg|
        @errors << msg
      end
    end
    respond_to :js

  end

end