require 'rails_helper'

#CREATE TABLE "places" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "name" varchar, "address" varchar,
#"created_at" datetime NOT NULL, "updated_at" datetime NOT NULL, "site" varchar, "place_id" varchar, "city" varchar,
#"cc" varchar);


RSpec.describe Place do
  it "is valid" do
    place=Place.new(name: "mizzica", address: "piazza bologna", site: "google", place_id: "rasd0",city: "Rome", cc: "IT")
    expect(place).to be_valid
  end

  it "is not valid without name" do
    place=Place.new(name: nil, address: "piazza bologna", site: "google", place_id: "rasd0",city: "Rome", cc: "IT")
    expect(place).not_to be_valid
  end

  it "is not valid without address" do
    place=Place.new(name: "mizzica", address: nil, site: "google", place_id: "rasd0",city: "Rome", cc: "IT")
    expect(place).not_to be_valid
  end

  it "is not valid without site" do
    place=Place.new(name: "mizzica", address: "piazza bologna", site: nil, place_id: "rasd0",city: "Rome", cc: "IT")
    expect(place).not_to be_valid
  end

  it "is not valid without place_id" do
    place=Place.new(name: "mizzica", address: "piazza bologna", site: "google", place_id: nil,city: "Rome", cc: "IT")
    expect(place).not_to be_valid
  end

  it "is not valid without city" do
    place=Place.new(name: "mizzica", address: "piazza bologna", site: "google", place_id: "rasd0",city: nil, cc: "IT")
    expect(place).not_to be_valid
  end

  it "is not valid without cc" do
    place=Place.new(name: "mizzica", address: "piazza bologna", site: "google", place_id: "rasd0",city: "Rome", cc: nil)
    expect(place).not_to be_valid
  end

  it "is already in the db (unique: site-place_id)" do
    Place.create(name: "mizzica", address: "piazza bologna", site: "google", place_id: "rasd0",city: "Rome", cc: "IT")
    place=Place.new(name: "mizzica", address: "piazza bologna", site: "google", place_id: "rasd0",city: "Rome", cc: "IT")

    expect(place).not_to be_valid
  end

end
