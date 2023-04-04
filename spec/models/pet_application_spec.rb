require 'rails_helper'

RSpec.describe PetApplication, type: :model do
  describe 'relationships' do
    it { should belong_to(:pet) }
    it { should belong_to(:application) }
  end
  
  before(:each) do
    @shelter = Shelter.create!(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    @pet_1 = @shelter.pets.create!(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: true)
    @pet_2 = @shelter.pets.create!(name: 'Clawdia', breed: 'shorthair', age: 3, adoptable: true)
    @application = Application.create!(name: 'John Doe', address: '123 Main St', city: 'Aurora', state: 'CO', zip: '80041', description: 'I love animals', status: 'Pending')
    @application.pets << @pet_1
    @application.pets << @pet_2
  end
  
  describe 'callback method' do
    it 'changes application status to approved when all pets are approved' do
      @application.pet_applications.each do |pet_application|
        expect(pet_application.status).to eq('Pending')
      end

      @application.pet_applications.each do |pet_application|
        pet_application.update(status: 'Approved')
      end
      expect(@application.status).to eq('Approved')
    
    end

    it 'changes application status to rejected when any pet is rejected' do
      @application.pet_applications.first.update(status: 'Rejected')

      expect(@application.status).to eq('Rejected')
    end
  end
end