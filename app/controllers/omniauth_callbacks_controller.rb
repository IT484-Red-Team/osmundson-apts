# class OmniauthCallbacksController < Devise::OmniauthCallbacksController
#   def google_oauth2
#     @user = User.find_for_open_id(request.env["omniauth.auth"], current_user)
    
#     if @user
#       flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => "Google"
#       sign_in_and_redirect @user, :event => :authentication
#     else
#       session["devise.google_data"] = request.env["omniauth.auth"]
#       sredirect_to new_user_registration_url
#     end
#   end
# end
class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def google_oauth2
      # You need to implement the method below in your model (e.g. app/models/user.rb)
      @user = User.find_for_open_id(request.env["omniauth.auth"], current_user)

  if @user
        flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => "Google"
        sign_in_and_redirect @user, :event => :authentication
  else
        session["devise.google_data"] = request.env["omniauth.auth"]
        redirect_to new_user_registration_url
    end
  end
end
