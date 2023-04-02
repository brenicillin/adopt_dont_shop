class AdminApplicationsController < ApplicationController
  def index
    @applications = Application.all
  end

  def show
    @application = Application.find(params[:id])
    @pet_applications = @application.pet_applications
    # require 'pry'; binding.pry
    @pets = @application.pets
  end

  def approve_pet
    application = Application.find(params[:id])
    pet = Pet.find(params[:pet_id])
    pet_application = PetApplication.find_by(pet_id: pet.id, application_id: application.id)
    pet_application.update(status: "Approved")
    redirect_to admin_application_path(application)
  end

  def reject_pet
    application = Application.find(params[:id])
    pet = Pet.find(params[:pet_id])
    pet_application = PetApplication.find_by(pet_id: pet.id, application_id: application.id)
    pet_application.update(status: "Rejected")
    redirect_to admin_application_path(application)
  end
end