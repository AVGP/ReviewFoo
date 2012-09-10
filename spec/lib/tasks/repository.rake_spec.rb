require 'spec_helper'
require 'rake'

describe 'repository.rake tasks' do
  before do
    @rake = Rake::Application.new
    Rake.application = @rake
    load "lib/tasks/repository.rake"
    Rake::Task.define_task(:environment)
  end
  
  describe "repository:scan" do
    before do
      @taskName = "repository:scan"
      commitFactory = mock(Mercurial::CommitFactory)
      Struct.new("CommitFake", :author, :author_email, :hash_id, :date, :message, :branch_name, :diffs)
      Struct.new("DiffFake", :filename, :body)
      
      commitFactory.stub!(:all).and_return([
          Struct::CommitFake.new(
            "John Doe", 
            "john.doe@example.com", 
            "0abc123", 
            "01-02-2012 08:30", 
            "First", 
            "default", 
            [Struct::DiffFake.new("test.txt", "some diff content")]
          ),
          Struct::CommitFake.new(
            "Alice Aaron", 
            "alice.aaron@example.com", 
            "1def567", 
            "01-02-2012 08:40", 
            "Second", 
            "other_branch", 
            [Struct::DiffFake.new("other.txt", "some other diff content")]
          )
        ])
      
      repository = mock(Mercurial::Repository)
      repository.stub!(:id).and_return(1)
      repository.stub!(:commits).and_return(commitFactory)
      
      Mercurial::Repository.stub!(:open).and_return(repository)

      @repo = FactoryGirl.build(:repository)
      @repo.save
    end
    
    it "should persist the new commits" do
      Commit.all.count.should be 0
      @rake[@taskName].invoke
      Commit.all.count.should be 2      
    end
    
    it "should associate the commits with the right repository" do
      Commit.find(:all, :conditions => "repository_id = 1").count.should be 0
      @rake[@taskName].invoke
      Commit.find(:all, :conditions => "repository_id = 1").count.should be 2
    end

    it "should associate the commits with the right branch" do
      Commit.find(:all, :conditions => "branch_name = 'default'").count.should be 0
      @rake[@taskName].invoke
      Commit.find(:all, :conditions => "branch_name = 'default'").count.should be 1
    end    
    
    it "should not persist already persisted commits" do
      Commit.all.count.should be 0
      @rake[@taskName].invoke
      Commit.all.count.should be 2

      @rake[@taskName].reenable
      @rake[@taskName].invoke
      Commit.all.count.should be 2            
    end
    
    it "should persist the diffs along with the commits" do
      @rake[@taskName].invoke
      Commit.find(:all, :conditions => "branch_name = 'default'")[0].commit_diffs.count.should be 1
      
    end  
  end
end