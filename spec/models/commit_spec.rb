require 'spec_helper'

describe Commit do
  before :each do
    @repo = Repository.create(:url => "/a/b", :name => "Test")
  end
  
  it "should have the accepted property set to 0 by default" do
    Commit.create(
      :author => "Alice", 
      :hash_id => 123, 
      :message => "Hello world", 
      :repository_id => @repo.id
      ).accepted.should be 0
  end
end