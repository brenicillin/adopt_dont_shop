RSpec.describe 'the new application page' do
  describe 'the form' do
    it 'takes you to a new application page' do
      shelter = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
      pet_1 = Pet.create(adoptable: true, age: 7, breed: 'sphynx', name: 'Bare-y Manilow', shelter_id: shelter.id)
      pet_2 = Pet.create(adoptable: true, age: 3, breed: 'domestic pig', name: 'Babe', shelter_id: shelter.id)
      pet_3 = Pet.create(adoptable: true, age: 4, breed: 'chihuahua', name: 'Elle', shelter_id: shelter.id)
      
      visit "/pets"
      
      click_link("Start an Application")
      
      expect(page).to have_current_path("/applications/new")
      
      expect(page).to have_field("Name")
      fill_in "Name", with: "Bob"
      expect(page).to have_field("Address")
      fill_in "Address", with: "1234 Bob St."
      expect(page).to have_field("City")
      fill_in "City", with: "Bobville"
      expect(page).to have_field("State")
      fill_in "State", with: "FL"
      expect(page).to have_field("ZIP")
      fill_in "ZIP", with: "12345"
      expect(page).to have_field("Why mine would make a good home")
      fill_in "Why mine would make a good home", with: "I love cats"
      
      expect(page).to have_button("Submit")
      
      click_button("Submit")
      
      expect(page).to have_current_path("/applications/#{Application.last.id}")
      expect(page).to have_content("In Progress")
    end
    
    it 'requires all fields to be filled in' do
      visit "/applications/new"
      fill_in "Name", with: "Bob"
      click_button("Submit")
      
      expect(current_path).to eq("/applications/new")
    end
  end
end