require 'spec_helper'

describe SessionsController, "Authorization" do
  
  it "should create a user when credentials haven't been used before" do
    visit "/auth/github"
    current_path.should == "/auth/github/callback"
    User.last.email.should == "a@b.com"
    User.last.name.should == "Alice"
  end
  
  it "should not create a user when credentials have been used before" do
    User.create(:email => "a@b.com", :name => "Alice")
    visit "/auth/github"
    current_path.should == "/auth/github/callback"
    User.count.should == 1
  end
  
  it "should create the proper authorization for the user" do
    visit "/auth/github"
    current_path.should == "/auth/github/callback"
    user = User.last
    user.email.should == "a@b.com"
    user.name.should == "Alice"
    user.authorizations.count.should == 1
    user.authorizations.first.provider.should == "github"
    user.authorizations.first.uid.should == "123456"
  end
end