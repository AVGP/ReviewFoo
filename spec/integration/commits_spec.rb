require 'spec_helper'

describe "Commit detail page", :js => true do
  before :each do
    @repo = Repository.create(:name => "Test 1", :url => "/some/path/A")
    @commit = Commit.create(
      :repository_id => @repo.id, 
      :hash_id => "a123", 
      :message => "Test 1", 
      :branch_name => "default"
      )    
    @commitDiff = CommitDiff.create(
      :commit_id => @commit.id,
      :content => "Diff 1",
      :path => "/some/path"
    )
  end
  
  it "should display the commit message, the branch name and the hash" do
    visit commit_path(@commit)
    page.should have_content @commit.hash_id.to_s
    page.should have_content @commit.message
    page.should have_content @commit.branch_name
  end
  
  it "should display the diffs for that commit and their contents and paths" do
    visit commit_path(@commit)
    page.should have_content @commitDiff.content
    page.should have_content @commitDiff.path
  end
  
  it "should use snippet.js to spice up the display of the diffs" do
    visit commit_path(@commit)
    page.should have_selector("div.snippet-wrap pre.diff ol")
  end
end