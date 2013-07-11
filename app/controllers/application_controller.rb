class ApplicationController < ActionController::Base
  protect_from_forgery

  def after_sign_in_path_for(resource_or_scope)
    if current_admin
      home_admins_dashboard_index_path
    end
  end
end
