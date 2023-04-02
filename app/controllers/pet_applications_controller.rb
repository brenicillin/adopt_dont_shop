class PetApplicationsController < ApplicationController
  def create
    application = Application.find(params[:application_id])
    pets = application.pets.uniq
    if pets.length == 1
      params[:pet_id] = pets.first.id
      PetApplication.create!(pet_application_params)
    else
      pets.each do |pet|
        params[:pet_id] = pet.id
        PetApplication.create!(pet_application_params)
      end
    end
    application.update(status: "Pending")
    redirect_to "/applications/#{params[:application_id]}"
  end

  private
  def pet_application_params
    params.permit(:application_id, :pet_id)
  end
end