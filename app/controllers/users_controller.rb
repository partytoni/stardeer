class UsersController < ApplicationController
  helper_method :users_posts

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.paginate(page: params[:page])
  end

  def users_posts()
    @lista=[]
    @posts= Post.all
    @posts.each do |p|
      @lista << p.text if p.user_id==current_user.id
    end
    @lista
  end

end
