require 'rails_helper'

RSpec.describe 'Admin Applications Index Page' do
  before(:each) do
    @application1 = Application.create!(name: 'John Doe', address: '123 Main St', city: 'Aurora', state: 'CO', zip: '80041', description: 'I love animals', status: 'Pending')
    @application2 = Application.create!(name: 'Jane Doe', address: '123 Main St', city: 'Aurora', state: 'CO', zip: '80041', description: 'I love animals', status: 'In Progress')
  end

  describe 'Displays all applications' do
    it 'When I visit the admin applications index page, I see all applications in the system by name' do
      visit '/admin/applications'

      expect(page).to have_content(@application1.name)
      expect(page).to have_content(@application2.name)
    end
  end
end