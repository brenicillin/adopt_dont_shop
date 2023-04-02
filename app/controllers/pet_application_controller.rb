class PetApplicationController < ApplicationController
  def create
    @PetApplication = PetApplication.new(pet_application_params)
  end

  private
  def pet_application_params
    params.permit(:pet_id, :application_id)
  end
end