require 'rails_helper'


RSpec.describe 'Application Show Page' do
  before(:each) do
    @shelter = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    @pet_1 = Pet.create(adoptable: true, age: 1, breed: 'sphynx', name: 'Lucille Bald', shelter_id: @shelter.id)
    @pet_2 = Pet.create(adoptable: true, age: 3, breed: 'doberman', name: 'Lobster', shelter_id: @shelter.id)
    @pet_3 = Pet.create(adoptable: true, age: 2, breed: 'sphynx', name: 'Sphynx', shelter_id: @shelter.id)
    @application_1 = Application.create!(name: 'John Doe', address: '123 Main St', city: 'Aurora', state: 'CO', zip: '80041', description: 'I love animals', status: 'In Progress')
    @application_2 = Application.create!(name: 'Jane Doe', address: '123 Main St', city: 'Aurora', state: 'CO', zip: '80041', description: 'I love animals', status: 'In Progress')
    PetApplication.create!(pet_id: @pet_1.id, application_id: @application_1.id)
    PetApplication.create!(pet_id: @pet_3.id, application_id: @application_1.id)
  end
  
   describe 'As a visitor' do
    it 'I can see the application and its attributes' do
      visit "/applications/#{@application_1.id}"
      
      expect(page).to have_content(@application_1.name)
      expect(page).to have_content(@application_1.address)
      expect(page).to have_content(@application_1.city)
      expect(page).to have_content(@application_1.state)
      expect(page).to have_content(@application_1.zip)
      expect(page).to have_content(@application_1.description)
      expect(page).to have_content("Lucille Bald")
      expect(page).to have_content("Sphynx")
      expect(page).to have_content(@application_1.status)
    end
  end

  describe 'As a visitor' do
    describe 'When I visit an applications show page' do
      it 'I can see a section to search for pets by name' do
        visit "/applications/#{@application_1.id}"
        
        expect(page).to have_content("Add Pet to Application")
        expect(page).to have_content("Pet name")
        expect(page).to have_field(:pet_name)
        expect(page).to have_button("Search")
      end

      it 'I can search for pets by name' do
        visit "/applications/#{@application_1.id}"

        fill_in :pet_name, with: "Lucille"
        click_button "Search"
        
        expect(current_path).to eq("/applications/#{@application_1.id}")
        expect(page).to have_content("Lucille Bald")
        expect(page).to_not have_content("Lobster")
      end

      it 'I can add a pet to the application' do
        visit "/applications/#{@application_1.id}"

        fill_in :pet_name, with: "Lobster"
        click_button "Search"
        click_button "Adopt this Pet"
        
        expect(page).to have_content("Lobster")
      end
    end
  end

  describe 'application form' do
    it 'does not render form if no pet is present' do
      visit "/applications/#{@application_2.id}"


      expect(page).to_not have_field(:description)
      expect(page).to_not have_button("Submit Application")
    end

    it 'renders form with one pet correctly' do
      @application_2.pets << @pet_1
      visit "/applications/#{@application_2.id}"

      expect(page).to have_content("Why I'd make a good owner for this pet:")
      expect(page).to have_field(:description)
      expect(page).to have_button("Submit Application")
    end
  
    it 'renders form with multiple pets correctly' do
      @application_2.pets << @pet_1
      @application_2.pets << @pet_2
      visit "/applications/#{@application_2.id}"

      expect(page).to have_content("Why I'd make a good owner for these pets:")
      expect(page).to have_field(:description)
      expect(page).to have_button("Submit Application")
    end
  end

  describe 'As a visitor' do
    describe 'When I visit an applications show page and search for pets by name' do
      it 'US8: I see any pet whose name partially matches my search' do
        visit "/applications/#{@application_1.id}"

        fill_in :pet_name, with: 'ob'
        click_button 'Search'

        expect(page).to have_content('Lobster') 
      end

      it 'US9: my search is case insensitive' do
        @pet_uppercase = Pet.create(adoptable: true, age: 2, breed: 'boxer', name: 'FLUFFY', shelter_id: @shelter.id)

        visit "/applications/#{@application_1.id}"

        fill_in :pet_name, with: 'luf'
        click_button 'Search'

        expect(page).to have_content('FLUFFY')
      end
    end
  end
end