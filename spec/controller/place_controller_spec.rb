require 'rails_helper'

RSpec.describe PlacesController, type: :controller do

  before :each do
    @place= Place.create(name: "mizzica", address: "Piazza Bologna", site: "google", place_id: "varchar", city: "Roma", cc: "IT")
  end

  it "should not get places" do
    get :show, user_id:1
    expect(response).to_not render_template :show
   end

  it "should get places" do
    get :show,   user_id:1
    expect(response).to render_template :show
  end

end
