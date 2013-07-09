class Users::DashboardController < ApplicationController
  before_filter :authenticate_user!
  layout 'application_users_new'

  def index
    @sourced_jobs = Sourcing.where(:user_id => current_user.id).order("created_at DESC").page(params[:sourced_page]).per(5)
    @applied_jobs = current_user.applied_jobs.where("status != ?", "Sourced").order("created_at DESC").page(params[:applied_page]).per(5)
  end

  def applied_job
    @applied_job = AppliedJob.find(params[:id])
  end

  def sourced_job
    @sourced_job = Sourcing.find(params[:id])
  end

  def job_apply
    @new_job = AppliedJob.create(:user_id => current_user.id, :requisition_id => params[:req_id], :resume_id => current_user.resume.id)
    redirect_to :back
    flash[:notice] = "#{params[:job_code]} applied successfully."
  end

end
