class Application < ApplicationRecord
  has_many :pet_applications, dependent: :destroy
  has_many :pets, through: :pet_applications

  validates :name, :address, :city, :state, :description, :status, presence: true
  validates :zip, presence: true, numericality: true, length: { is: 5 }
  after_update :update_pet_status

  private
  def update_pet_status
    if self.status == 'Approved'
      pets.each do |pet|
        pet.update(adoptable: false)
      end
    end
  end
end
