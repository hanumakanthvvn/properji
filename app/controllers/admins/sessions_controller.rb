class Admins::SessionsController < Devise::SessionsController
  layout "administration"

  def create
    self.resource = warden.authenticate!(auth_options)
    set_flash_message(:notice, :signed_in) if is_navigational_format?
    sign_in(resource_name, resource)
    respond_with resource, :location => home_admins_dashboard_index_path
  end

end
