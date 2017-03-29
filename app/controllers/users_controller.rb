class UsersController < ApplicationController
  helper_method :users_posts

  def index
    @users = User.all
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
      print("\n\n\nbanna sto cazzo\n\n\n")
      @u=User.find(params[:id])
      if @u.superadmin_role? or @u.supervisor_role
        redirect_to "/ban" and return
      end
      @u.banned=!@u.banned
      if @u.save
        redirect_to '/ban', :alert => "Bannato correttamente"
      else
        redirect_to '/ban', :alert => "Che cazzo è successo?"
      end
    else
      redirect_to '/ban'
    end
  end

end
