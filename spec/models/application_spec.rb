require 'rails_helper'

RSpec.describe Application, type: :model do
  describe "relationships" do
    it {should have_many :pet_applications}
    it {should have_many(:pets).through(:pet_applications)}
  end

  describe 'validations' do
    it {should validate_presence_of :name}
    it {should validate_presence_of :address}
    it {should validate_presence_of :city}
    it {should validate_presence_of :state}
    it {should validate_presence_of :zip}
    it {should validate_presence_of :description}
    it {should validate_presence_of :status}
  end

  describe '#update_pet_status' do
    it 'changes pet status to not adoptable when application is approved' do
      @shelter = Shelter.create!(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
      @pet_1 = @shelter.pets.create!(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: true)
      @application = Application.create!(name: 'John Doe', address: '123 Main St', city: 'Aurora', state: 'CO', zip: '80041', description: 'I love animals', status: 'Pending')
      @application.pets << @pet_1
      
      expect(@pet_1.adoptable).to eq(true)
      @application.update(status: 'Approved')
      @pet_1.reload
      expect(@pet_1.adoptable).to eq(false)
    end
  end
end