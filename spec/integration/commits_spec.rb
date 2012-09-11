require 'spec_helper'

describe "Commit detail page" do
  before :each do
    @repo = Repository.create(:name => "Test 1", :url => "/some/path/A")
    @commit = Commit.create(
      :repository_id => @repo.id, 
      :hash_id => "a123", 
      :message => "Test 1", 
      :branch_name => "default"
      )    
  end
  
  it "should display the commit message, the branch name and the hash" do
    visit "/commit/" + @commit.hash_id.to_s
    page.should have_content @commit.hash_id.to_s
    page.should have_content @commit.message
    page.should have_content @commit.branch_name
  end
end