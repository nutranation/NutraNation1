module UsersHelper
  def current_user?(user)
    user == current_user 
  end
  
  def admin?(user)
    if user.admin
      true
    else
      false
    end
  end

end
