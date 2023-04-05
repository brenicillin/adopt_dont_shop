class PetApplication < ApplicationRecord
  belongs_to :pet
  belongs_to :application

  after_commit :update_application_status, on: :update

   private 
   
  def update_application_status
    if self.application.pet_applications.all? {|pet_application| pet_application.status == 'Approved'}
      application.update(status: 'Approved')
    elsif self.application.pet_applications.any? {|pet_application| pet_application.status == 'Rejected'}
      application.update(status: 'Rejected')
    end
  end
end