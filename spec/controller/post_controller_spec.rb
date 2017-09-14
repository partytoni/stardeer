require 'rails_helper'

RSpec.describe PostController, type: :controller do
  before :each do
    post=Post.new(user_id: nil, text: "---", rating: 1, place_id: 1)
  end

  it "should get index" do
    get posts_url
    assert_response :success
  end

  it "should get new" do
    get new_post_url
    assert_response :success
  end

  it "should create post" do
    assert_difference('Post.count') do
      post posts_url, params: { post: { text: @post.text, user_id: @post.user_id } }
    end

    assert_redirected_to post_url(Post.last)
  end

  it "should show post" do
    get post_url(@post)
    assert_response :success
  end

  it "should get edit" do
    get edit_post_url(@post)
    assert_response :success
  end

  it "should update post" do
    patch post_url(@post), params: { post: { text: @post.text, user_id: @post.user_id } }
    assert_redirected_to post_url(@post)
  end

  it "should destroy post" do
    assert_difference('Post.count', -1) do
      delete post_url(@post)
    end

    assert_redirected_to posts_url
  end
end
