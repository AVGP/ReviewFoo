require 'spec_helper'

describe Authorization do
  it "should not be valid if provider or uid is missing" do
    Authorization.new(:provider => "github").should_not be_valid
    Authorization.new(:uid => 123).should_not be_valid
  end
  
  it "should be valid, if provider and uid are provided" do
    Authorization.new(:provider => "github", :uid => 123).should be_valid
  end
end
