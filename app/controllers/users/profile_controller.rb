class Users::ProfileController < ApplicationController
  before_filter :authenticate_user!
  before_filter :find_user, :except => ["edit_resume","update_resume", "new_resume", "create_resume"]
  layout "application_users_new"
  def index;
    unless @user.resume
      redirect_to new_resume_path
    end
  end

  def edit; end

  def change_password; end

  def new_resume
    @resume = Resume.new
  end

  def edit_resume
    @resume = current_user.resume
  end

  def update
    if @user.update_attributes(params[:user])
      flash[:notice] = "Profile Updated Successfully."
      redirect_to profile_path
    else
      flash.now[:error] = I18n.t "correct_marked_fields"
      render 'edit'
    end
  end


  def update_password
    #from https://github.com/plataformatec/devise/wiki/How-To:-Allow-users-to-edit-their-password
    if @user.update_with_password(params[:user])
      flash[:notice] = "Your password has been changed successfully."
      sign_in @user, :bypass => true
      redirect_to profile_path
    else
      flash.now[:error] = I18n.t "correct_marked_fields"
      render 'change_password'
    end
  end

  def create_resume
    @resume = Resume.new(params[:resume])
    @resume.user = current_user
    if @resume.save
      flash[:notice] = "Resume Updated Successfully."
      redirect_to profile_path
    else
      flash.now[:error] = I18n.t "correct_marked_fields"
      render 'new_resume'
=begin
respond_to do |format|
        format.html { render action: 'new_resume' }
        format.json { render json: @resume.errors, status: :unprocessable_entity }
      end
=end

    end
  end

  def update_resume
    @resume = Resume.find(current_user.resume.id)
    if @resume.update_attributes(params[:resume])
      flash[:notice] = "Resume Updated Successfully."
      redirect_to profile_path
    else
      flash.now[:error] = I18n.t "correct_marked_fields"
      render 'edit_resume'
    end
  end

  private
  def find_user
    @user = current_user
  end
end
