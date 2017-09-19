require 'rails_helper'

RSpec.describe Post do
  it "is not valid without user_id" do
    post=Post.new(user_id: nil, text: "---", rating: 1, place_id: 1)
    expect(post).not_to be_valid
  end

  it "is not valid without text" do
    post=Post.new(user_id: 1, text: nil, rating: 1, place_id: 1)
    expect(post).not_to be_valid
  end

  it "is not valid without rating" do
    post=Post.new(user_id: 1, text: "---", rating: nil, place_id: 1)
    expect(post).not_to be_valid
  end

  it "is not valid without place_id" do
    post=Post.new(user_id: 1, text: "---", rating: 1, place_id: nil)
    expect(post).not_to be_valid
  end

  it "is valid with text of 139" do
    post=Post.new(user_id: 1, text: "a"*139, rating: 1, place_id: 1)
    expect(post).to be_valid
  end

  it "is not valid with text of 141" do
    post=Post.new(user_id: 1, text: "a"*141, rating: 1, place_id: 1)
    expect(post).not_to be_valid
  end

  it "is not valid with rating greater than 5" do
    post=Post.new(user_id: 1, text: "a"*139, rating: 8, place_id: 1)
    expect(post).not_to be_valid
  end

  it "is not valid with rating less than 1" do
    post=Post.new(user_id: 1, text: "a"*139, rating: 0, place_id: 1)
    expect(post).not_to be_valid
  end

  it "is already in the db (unique: user_id-place_id)" do
    Post.create(user_id: 1, text: "a"*139, rating: 1, place_id: 1)
    post=Post.new(user_id: 1, text: "a"*139, rating: 1, place_id: 1)
    expect(post).not_to be_valid
  end


end
