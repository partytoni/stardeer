require 'rails_helper'

RSpec.describe Place do
  it "is not valid without name" do
    place=Place.new(name: nil, site: "google", address: "via pulci", place_id: "123", city: "Roma", cc: "IT")
    expect(place).not_to be_valid
  end

  it "is not valid without site" do
    place=Place.new(name: "---", site: nil, address: "via pulci", place_id: "123", city: "Roma", cc: "IT")
    expect(place).not_to be_valid
  end

  it "is not valid without address" do
    place=Place.new(name: "---", site: "google", address: nil, place_id: "123", city: "Roma", cc: "IT")
    expect(place).not_to be_valid
  end

  it "is not valid without place_id" do
    place=Place.new(name: "---", site: "google", address: "via pulci", place_id: nil, city: "Roma", cc: "IT")
    expect(place).not_to be_valid
  end

  it "is not valid without city" do
    place=Place.new(name: "---", site: "google", address: "via pulci", place_id: "123", city: nil, cc: "IT")
    expect(place).not_to be_valid
  end

  it "is not valid without cc" do
    place=Place.new(name: "---", site: "google", address: "via pulci", place_id: "123", city: "Roma", cc: nil)
    expect(place).not_to be_valid
  end
end
