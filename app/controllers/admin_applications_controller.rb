class AdminApplicationsController < ApplicationController
  def index
    @applications = Application.all
  end

  def show
    @application = Application.find(params[:id])
    @pet_applications = @application.pet_applications
    @pets = @application.pets
  end
end