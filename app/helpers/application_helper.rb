module ApplicationHelper
  def search_user(s)
    @all_users = User.all
    @users=[]
    @all_users.each do |u|
      name=u.name.downcase
      if s.include? name
        @users << u
      end
    end
    @users
  end

end
