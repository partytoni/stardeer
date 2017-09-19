require 'rails_helper'

RSpec.describe PostsController, type: :controller do
  include Devise::Test::ControllerHelpers


  before :each do
    @place= Place.create(name: "mizzica", address: "Piazza Bologna", site: "google", place_id: "varchar", city: "Roma", cc: "IT")
    @post= Post.new(text: "---", rating: 1, place_id: @place.id, user_id: "1")
  end

  it "should create post" do
    @post.save
    expect(Post.first).to_not be_nil
  end

  it "should destroy post" do
    @post.save
    id=@post.id
    @post.destroy
    post=Post.find_by_id(id)
    expect(post).to be_nil
  end


  it "should update params of post (e.g. name)" do
    @post.save
    @post.text="molto buono ---"
    @post.save
    id=@post.id
    post=Post.find_by_id(id)
    expect(post.text).to start_with("molto buono")
  end

  it "should be connected to a place" do
    place_id=@post.place_id
    expect(place_id).to be(@place.id)
  end

end
