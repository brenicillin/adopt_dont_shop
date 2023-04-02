require 'rails_helper'

RSpec.describe 'Admin Shelters Index' do
  before(:each) do
    @shelter1 = Shelter.create!(name: 'Aurora Shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    @shelter2 = Shelter.create!(name: 'Boulder Shelter', city: 'Boulder, CO', foster_program: true, rank: 7)
    @shelter3 = Shelter.create!(name: 'Denver Shelter', city: 'Denver, CO', foster_program: true, rank: 10)

    @application_1 = Application.create!(name: 'John Doe', address: '123 Main St', city: 'Aurora', state: 'CO', zip: '80041', description: 'I love animals', status: 'Pending')
    @application_2 = Application.create!(name: 'Jane Doe', address: '123 Main St', city: 'Aurora', state: 'CO', zip: '80041', description: 'I love animals', status: 'In Progress')

    @shelter1.pets.create!(adoptable: true, age: 1, breed: 'Sphynx', name: 'Lucille Bald', applications: [@application_1])
    @shelter2.pets.create!(adoptable: true, age: 2, breed: 'Doberman', name: 'Lobster', applications: [@application_2])
  end

  describe 'As a visitor' do
    describe 'When I visit the admin shelter index' do
      it 'US10: I see all Shelters in the system listed in reverse alphabetical order by name' do
        visit '/admin/shelters'

        expect(page.body.index('Denver Shelter')).to be < page.body.index('Boulder Shelter')
        expect(page.body.index('Boulder Shelter')).to be < page.body.index('Aurora Shelter')
      end

      it 'US11: I see a section for "Shelters with Pending Applications" listing the name of every shelter that has a pending application' do
        visit '/admin/shelters'
      
        within('#shelters-with-pending-applications') do
          expect(page).to have_content('Aurora Shelter')
          expect(page).to_not have_content('Boulder Shelter')
          expect(page).to_not have_content('Denver Shelter')
        end
      end      
    end
  end
end
