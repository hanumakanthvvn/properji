class Users::OmniauthCallbacksController < ApplicationController

  def linkedin
    @user = User.find_for_linkedin_oauth(request.env["omniauth.auth"], current_user)
    puts @user.inspect
    if @user.persisted?
      flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => "LinkedIn"
      sign_in_and_redirect @user, :event => :authentication
    else
      flash.now[:notice] = "Successfully authorized from LinkedIn.Please save the details below and continue."
    end
  end

  def create
    @user = User.new(params[:user])
    @user.password =  Devise.friendly_token[0,20]
    if @user.save
      sign_in_and_redirect @user, :event => :authentication
    else
      flash.now[:error] = I18n.t "correct_marked_fields"
      render @user.provider
    end
  end



  def passthru
    render :file => "#{Rails.root}/public/404.html", :status => 404, :layout => false
    # Or alternatively,
    # raise ActionController::RoutingError.new('Not Found')
  end

  def check_email_existence
    status = User.find_by_email(params[:email]) ? 'true' : 'false'
    render json: status.to_json
  end

  def failure
    redirect_to root_path
    flash[:notice] = "Could not authorize, please login again from facebook or signup to continue"
  end


end
