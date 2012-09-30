require 'spec_helper'

describe SessionsController do
  
  before :each do
    request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:github]
  end
  
  describe "GET 'new'" do
    it "returns http success" do
      get 'new'
      response.should be_success
    end
  end
  
  describe "GET 'failure'" do
    it "returns http success" do
      get 'failure'
      response.should be_success
    end
  end

end
