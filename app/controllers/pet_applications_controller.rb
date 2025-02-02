class PetApplicationsController < ApplicationController
  def create
    application = Application.find(params[:application_id])
    application.update(status: "Pending")
    redirect_to "/applications/#{params[:application_id]}"
  end

  def status
    @pet_application = PetApplication.find_by(pet_id: params[:pet_id], application_id: params[:id])
    @pet_application.update(status: params[:status])
    redirect_to admin_application_path(params[:id])
  end

  private
  def pet_application_params
    params.permit(:application_id, :pet_id)
  end
end