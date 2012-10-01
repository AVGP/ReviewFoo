class SessionsController < ApplicationController
  def new
  end

  def create
    auth_hash = request.env['omniauth.auth']
    @auth = Authorization.find_by_provider_and_uid(auth_hash[:provider], auth_hash[:uid])
    if @auth.nil?
      @user = User.new(
        :name => auth_hash["info"]["nickname"],
        :email => auth_hash["info"]["email"]
      )
    
      @user.authorizations.build(
        :provider => auth_hash["provider"], 
        :uid => auth_hash["uid"]
      )
      @user.save

      session[:user_id] = 1
      redirect_to "/"
    else
      session[:user_id] = 1
      redirect_to "/"
    end
  end

  def failure
  end
end
