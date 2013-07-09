class HomeController < ApplicationController

  def index

  end

  def search
    params[:name].present? || params[:name] = "!!"
    @spaces = Space.address_like(params[:name]).paginate(:page => params[:page])
    respond_to do |format|
      format.js
    end
  end

  def profile
    @user = current_user
  end

  def update_profile
    @user = current_user
    if @user.update_attributes(params[:user])
      flash[:notice] = "Successfully updated your profile."
      redirect_to root_path
    else
      flash.now[:error] = "Failed to update your profile."
      render action: "profile"
    end
  end

end
