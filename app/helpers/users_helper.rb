module UsersHelper

  def admin?(user)
    if user.admin
      true
    else
      false
    end
  end
  
  

end
