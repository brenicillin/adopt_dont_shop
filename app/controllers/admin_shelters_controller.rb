class AdminSheltersController < ApplicationController
  def index
    @shelters = Shelter.find_by_sql('SELECT * FROM shelters ORDER BY name DESC')
    @shelters_with_pending_applications = Shelter.with_pending_applications
  end
end