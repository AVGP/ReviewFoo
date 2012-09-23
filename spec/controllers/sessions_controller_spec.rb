require 'spec_helper'

describe SessionsController do

  describe "GET 'new'" do
    it "returns http success" do
      get 'new'
      response.should be_success
    end
  end

  describe "GET 'create'" do
    it "returns http success" do
      get '/auth/github/callback'
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
