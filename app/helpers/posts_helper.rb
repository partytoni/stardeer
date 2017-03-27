module PostsHelper
  def sei_proprio_tu?(post)
    post.user_id==current_user.id
  end

end
