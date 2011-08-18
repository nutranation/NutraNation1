class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    # You need to implement the method below in your model
    @user = User.find_for_facebook_oauth(env["omniauth.auth"], current_user)
    if @user.persisted?
      flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => "Facebook"
      sign_in_and_redirect @user, :event => :authentication
    else
      session["devise.facebook_data"] = env["omniauth.auth"]
      redirect_to new_user_registration_url
    end
  end
  
  def twitter
    @user = User.find_or_create_for_twitter(env["omniauth.auth"])
    flash[:notice] = "Signed in with #{twitter.to_s.titleize} successfully."
    sign_in_and_redirect @user, :event => :authentication
  end
  
  def linked_in
    @user = User.find_or_create_for_linked_in(env["omniauth.auth"]) 
    flash[:notice] = "Signed in with #{linked_in.to_s.titleize} successfully."
    sign_in_and_redirect @user, :event => :authentication
    rescue Exception => e
        # Just spit out the error message and a backtrace.
    render :text => "<html><body><pre>" + e.to_s + "</pre><hr /><pre>" + e.backtrace.join("\n") + "</pre></body></html>"
  end
  
  
  
  def passthru
    render :file => "#{Rails.root}/public/404.html", :status => 404, :layout => false
  end
end