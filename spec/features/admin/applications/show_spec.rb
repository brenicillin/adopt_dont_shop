require 'rails_helper'

RSpec.describe 'Admin Applications Show Page' do
  before(:each) do
    @shelter_1 = Shelter.create!(name: 'Aurora Shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    @shelter_2 = Shelter.create!(name: 'Boulder Shelter', city: 'Boulder, CO', foster_program: true, rank: 7)
    @shelter_3 = Shelter.create!(name: 'Denver Shelter', city: 'Denver, CO', foster_program: true, rank: 10)
    @shelter_1.pets.create!(adoptable: true, age: 1, breed: 'Sphynx', name: 'Lucille Bald')
    @shelter_2.pets.create!(adoptable: true, age: 2, breed: 'Doberman', name: 'Lobster')
    @shelter_2.pets.create!(adoptable: true, age: 3, breed: 'Labrador', name: 'Buddy')
    @application_1 = Application.create!(name: 'John Doe', address: '123 Main St', city: 'Aurora', state: 'CO', zip: '80041', description: 'I love animals', status: 'Pending')
    @application_2 = Application.create!(name: 'Jane Doe', address: '123 Main St', city: 'Aurora', state: 'CO', zip: '80041', description: 'I love animals', status: 'In Progress')
    @pet_application_1 = PetApplication.create!(pet_id: @shelter_1.pets.first.id, application_id: @application_1.id)
    @pet_application_2 = PetApplication.create!(pet_id: @shelter_2.pets.first.id, application_id: @application_2.id)
    @pet_application_3 = PetApplication.create!(pet_id: @shelter_2.pets.last.id, application_id: @application_2.id)
  end

  describe 'As a visitor' do
    it 'When I visit an admin application show page, I see' do
      visit "/admin/applications/#{@application_1.id}"

      expect(page).to have_content(@application_1.name)
      expect(page).to have_content(@application_1.address)
      expect(page).to have_content(@application_1.city)
      expect(page).to have_content(@application_1.state)
      expect(page).to have_content(@application_1.zip)
      expect(page).to have_content(@application_1.description)
      expect(page).to have_content(@application_1.status)
      expect(page).to have_content(@shelter_1.pets.first.name)
      expect(page).to have_content('Pending')
      expect(page).to have_button('Approve')
      expect(page).to_not have_content(@shelter_2.pets.first.name)
      expect(page).to_not have_content(@shelter_2.pets.last.name)
    end

    it 'when I approve a pet for a specific application, I am returned to the show page' do
      visit "/admin/applications/#{@application_1.id}"

      expect(page).to have_button('Approve')
      click_button 'Approve'

      expect(current_path).to eq("/admin/applications/#{@application_1.id}")
      expect(page).to have_content('Approved')
    end

    it 'when I reject a pet for a specific application, I am returned to the show page' do
      visit "/admin/applications/#{@application_1.id}"

      expect(page).to have_button('Reject')
      click_button 'Reject'

      expect(current_path).to eq("/admin/applications/#{@application_1.id}")
      expect(page).to have_content('Rejected')
    end
  end

  describe 'Approving an application' do
    it 'When all pets on an application have been approved, the application status changes to "Approved"' do
      visit "/admin/applications/#{@application_2.id}"
      all('input[type="submit"][value="Approve"]').first.click
      all('input[type="submit"][value="Approve"]').last.click
      expect(@application_2.reload.status).to eq('Approved')
    end
  end

  describe 'Rejecting an application' do
    it 'When any pet on an application has been rejected, the application status changes to "Rejected"' do
     visit "/admin/applications/#{@application_2.id}"
     all('input[type="submit"][value="Reject"]').first.click
     expect(@application_2.reload.status).to eq('Rejected')
    end
  end
end