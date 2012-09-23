require 'spec_helper'

describe User do
  it "should be invalid if the name is not specified" do
    User.new(:email => "a@b.com").should_not be_valid
  end
  
  it "should be invalid if the email is missing" do
    User.new(:name => "Test").should_not be_valid
  end
  
  it "should be valid if email and name are given" do
    User.new(:name => "Test", :email => "a@b.com").should be_valid
  end
  
  it "should restrict duplicate user names" do
    User.create(:name => "Test", :email => "a@b.com")
    User.create(:name => "Test", :email => "b@c.com").should_not be_valid
  end
  
  it "should restrict duplicate user email addresses" do
    User.create(:name => "Test", :email => "a@b.com")
    User.create(:name => "Test 2", :email => "a@b.com").should_not be_valid
  end
end