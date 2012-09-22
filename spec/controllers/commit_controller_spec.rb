require 'spec_helper'

describe CommitController do

  describe "GET 'commit/:hash'" do
    it "returns http success" do
      repo = Repository.create(:name => "Test 1", :url => "/some/path/A")
      aCommit = Commit.create(
      :repository_id => repo.id, 
      :hash_id => "a123", 
      :message => "Test 1", 
      :branch_name => "default"
      )    
      aCommit = Commit.create()
      puts commit_path(aCommit.hash_id.to_s)
      response.should be_success
    end
  end

  describe "GET 'comment'" do
    it "returns http success" do
      get 'comment'
      response.should be_success
    end
  end

end
