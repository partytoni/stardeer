require 'rails_helper'

RSpec.describe PlacesController, type: :controller do

  before :each do
    #@place = places(:one)
    @place= Place.create(name: "mizzica", address: "Piazza Bologna", site: "google", place_id: "varchar", city: "Roma", cc: "IT")
  end

  it "should get index" do
    get :index
    expect(response).to render_template :index
  end

  it "should get new" do
    get :new, :show
    expect(response).to render_template :show
  end

  it "should create place" do
    assert_difference('Place.count') do
      post places_url, params: { place: { address: @place.address, name: @place.name } }
    end

    expect(response).to redirect_to(place_url(Place.last))
  end

  it "should show place" do
    get place_url(@place)
    expect(response).to render_template :show
  end

  it "should get edit" do
    get edit_place_url(@place)
    expect(response).to render_template :show
  end

  it "should update place" do
    patch place_url(@place), params: { place: { address: @place.address, name: @place.name } }
    expect(response).to redirect_to(place_url(@place))
  end

  it "should destroy place" do
    assert_difference('Place.count', -1) do
      delete place_url(@place)
    end

    expect(response).to redirect_to(places_url)
  end
end
