class HomeController < ApplicationController

  def index

  end

  def search
    @spaces = Space.address_like(params[:name])
    respond_to do |format|
      format.js
    end
  end

end
