require 'rails_helper'

RSpec.describe PlacesController, type: :controller do
  include Devise::Test::ControllerHelpers


  before :each do
    @place= Place.new(name: "mizzica", address: "Piazza Bologna", site: "google", place_id: "varchar", city: "Roma", cc: "IT")
  end

  it "should create place" do
    @place.save
    expect(Place.first).to_not be_nil
  end

  it "should destroy place" do
    @place.save
    id=@place.id
    @place.destroy
    place=Place.find_by_id(id)
    expect(place).to be_nil
  end


  it "should update params of place (e.g. name)" do
    @place.save
    @place.name="pizzeria mizzica"
    @place.save
    id=@place.id
    place=Place.find_by_id(id)
    expect(place.name).to start_with("pizzeria")
  end


end
