class SessionsController < ApplicationController
  def new
  end

  def create
    auth_hash = request.env['omniauth.auth']
    @user = User.new(
      :name => auth_hash["info"]["nickname"],
      :email => auth_hash["info"]["email"]
    )
    
    @user.authorizations.build(
      :provider => auth_hash["provider"], 
      :uid => auth_hash["uid"]
    )
    @user.save

    render :text => "Welcome #{@user.name}"
  end

  def failure
  end
end
