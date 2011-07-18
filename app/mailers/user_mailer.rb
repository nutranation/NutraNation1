class UserMailer < ActionMailer::Base
  default :from => "spencer.kline@gmail.com"
  
  
  def welcome_email(user)
      @user = user
      @url  = "http://nutranation.heroku.com/"
      mail(:to => user.email,
           :subject => "Welcome to NutraNation")
  end
  def comment_email(user)
  end
  
end
