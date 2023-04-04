class Application < ApplicationRecord
  has_many :pet_applications
  has_many :pets, through: :pet_applications

  validates :name, :address, :city, :state, :zip, :description, :status, presence: true
end
