class SessionsController < Clearance::SessionsController

    def create_from_omniauth  #15th
      
      auth_hash = request.env["omniauth.auth"]

      authentication = Authentication.find_by_provider_and_uid(auth_hash["provider"], auth_hash["uid"]) || Authentication.create_with_omniauth(auth_hash)
      if authentication.user
        user = authentication.user 
        authentication.update_token(auth_hash)
        @next = root_url
        @notice = "Signed in!"
      else
        user = User.create_with_auth_and_hash(authentication,auth_hash)
        @next = root_url 
        @notice = "New user created"
      end
      sign_in(user)
      redirect_to @next, :notice => @notice
    end

    # def create #coderwall
    # user = User.from_omniauth(env["omniauth.auth"])
    # session[:user_id] = user.id
    # redirect_to root_url
    # end

    # def destroy
    # session[:user_id] = nil
    # redirect_to root_url
    

  end
