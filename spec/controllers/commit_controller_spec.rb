require 'spec_helper'

describe CommitController do

  describe "GET 'show'" do
    it "returns http success" do
      get 'show'
      response.should be_success
    end
  end

  describe "GET 'comment'" do
    it "returns http success" do
      get 'comment'
      response.should be_success
    end
  end

  describe "GET 'react'" do
    it "returns http success" do
      get 'react'
      response.should be_success
    end
  end

end
