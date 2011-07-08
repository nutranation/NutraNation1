module ApplicationHelper
  
  # Return a title on a per-page basis.
  def title
    base_title = "NutraNation"
    if @title.nil?
      base_title
    else
      "#{base_title} | #{@title}"
    end
  end
  
  def logo
    image_tag("logo.png", :alt => "NutraNation",  :width => "127px", :height => "70px")
  end
  
  def current_user?(user)
    user == current_user 
  end
  
end
