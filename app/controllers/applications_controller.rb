class ApplicationsController < ApplicationController
  def index
    @applications = Application.all
  end
  
  def show
    @application = Application.find(params[:id])
    @pets = @application.pets
    @pet_search = params[:pet_name].present? ? Pet.search(params[:pet_name]) : []
  end

  def add_pet
    @application = Application.find(params[:id])
    pet = Pet.find(params[:pet_id])
    
    unless @application.pets.include?(pet)
      @application.pets << pet
    end
    
    redirect_to "/applications/#{@application.id}"
  end

  def new

  end

  def create
    @application = Application.new(application_params)
    if @application.valid?
      @application = Application.create!(application_params)
      redirect_to "/applications/#{@application.id}"
    else
      flash[:notice] = "Please fill out all fields."
      redirect_to "/applications/new"
    end
  end

  def approve_pet
    pet_application = PetApplication.find_by(pet_id: params[:pet_id], application_id: params[:id])
    pet_application.update(status: 'Approved')
    redirect_to admin_application_path(params[:id])
  end
  
  def reject_pet
    pet_application = PetApplication.find_by(pet_id: params[:pet_id], application_id: params[:id])
    pet_application.update(status: 'Rejected')
    redirect_to admin_application_path(params[:id])
  end

  private
  def application_params
    params.permit(:name, :address, :city, :state, :zip, :description)
  end
end