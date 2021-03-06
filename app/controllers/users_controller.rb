class UsersController < ApplicationController
  helper_method :users_posts

  def index
    @users1 = User.all
    @users = []
    @users1.each do |u|
      @users << u if current_user.following.include?(u)
    end
    @users
  end

  def show
    @user = User.find(params[:id])
  end

  def users_posts()
    @lista=[]
    @posts= Post.all
    @posts.each do |p|
      @lista << p.text if p.user_id==current_user.id
    end
    @lista
  end

  def ban_user #lo fa l'admin
    if current_user.superadmin_role? or current_user.supervisor_role?
      @u=User.find(params[:id])
      if @u.superadmin_role? or @u.supervisor_role
        redirect_to "/ban" and return
      end
      @u.banned=!@u.banned
      if @u.save
        if @u.banned
          message= "Bannato correttamente"
        else
          message= "Sbannato correttamente"
        end
        redirect_to '/ban', :alert => message
      else
        redirect_to '/ban', :alert => "Panico"
      end
    else
      redirect_to '/ban'
    end
  end

  def unfollow_user
    current_user.unfollow(User.find(params[:id]))
    redirect_to :back #"/users"
  end

  def follow_user
    if already_followed?(User.find(params[:id]), current_user.id)
      redirect_to '/search'
      return
    end
    current_user.follow(User.find(params[:id]))
    redirect_to :back
  end

  def users_posts(id)
    @posts=Post.where(user_id: id.to_i)
    @posts.each do |p|
      print("\n\n"+p.text)
    end
  end

  def already_followed?(uid, currentid)
    cose=Relationship.where(["follower_id = ? and followed_id = ?", currentid, uid])
    if cose==[]
      return false
    else
      return true
    end
  end

end
