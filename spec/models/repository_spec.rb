require 'spec_helper'

describe Repository do
  it "is not valid when no name is specified" do
    Repository.new(:url => "abc").should_not be_valid
  end
  
  it "is not valid when no url is specified" do
    Repository.new(:name => "test").should_not be_valid
  end
end
