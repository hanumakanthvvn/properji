class HomeController < ApplicationController

  def index

  end

  def search
    @spaces = Space.address_like(params[:name]).paginate(:page => params[:page],:per_page => 1)
    respond_to do |format|
      format.js
    end
  end

end
