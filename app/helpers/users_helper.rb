module UsersHelper

  def admin?(user)
    user.role=="a"
  end

  def mod?(user)
    user.role=="m"
  end

  
end
