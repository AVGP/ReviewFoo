require 'spec_helper'

describe "Repository index" do
  it "should have a link to create a new repository" do
    visit "/repositories/"
    click_link("New Repository")
    current_path.should == "/repositories/new"
  end
  
  it "should show existing repositories" do
    Repository.create(:name => "Test 1", :url => "/some/path/A")
    Repository.create(:name => "Test 2", :url => "/some/path/B")
    
    visit "/repositories"
    page.should have_content("Test 1")
    page.should have_content("Test 2")    
  end
  
  it "should allow the user to delete a repository", :js => true do
    Repository.create(:name => "Test", :url => "/some/path/A")
    
    visit "/repositories"
    click_on("Destroy")
    page.driver.browser.switch_to.alert.accept

    visit "/repositories" #This is a hack for the Selenium driver to have the data persisted
    Repository.find(:first, :conditions => "name = 'Test'").should be_nil
  end
  
end

describe "Adding a new repository" do
  it "should display an error message, when the name is not filled it" do
    visit "/repositories/new"
    fill_in("Url", :with => "/some/path/")
    click_on("Create Repository")
    
    page.should have_content "Name can't be blank"
  end

  it "should display an error message, when the url is not filled it" do
    visit "/repositories/new"
    fill_in("Name", :with => "Some Name")
    click_on("Create Repository")
    
    page.should have_content "Url can't be blank"
  end
  
  it "should create the new repository when the form is properly filled" do
    visit "/repositories/new"
    fill_in("Name", :with => "Test")
    fill_in("Url", :with => "/some/path")
    click_on("Create Repository")
    
    Repository.find(:first, :conditions => "name = 'Test'").should_not be_nil
  end
end

describe "Viewing a repository" do
  before :each do
    @repo = Repository.create(:name => "Test 1", :url => "/some/path/A")
    Commit.create(
      :repository_id => @repo.id, 
      :hash_id => "a123", 
      :message => "Test 1", 
      :branch_name => "default"
      )
    Commit.create(
      :repository_id => @repo.id, 
      :hash_id => "b456", 
      :branch_name => "other",
      :message => "Test 2"
      )
  end
  
  it "should display all the commits and their message" do
    
    visit "/repositories/" + @repo.id.to_s
    page.should have_content "a123 - Test 1"
    page.should have_content "b456 - Test 2"
  end
  
  it "should have links for the commits to the detail page of that commit" do
    visit "/repositories/" + @repo.id.to_s
    click_on("a123 - Test 1")
    current_path.should eq("/commit/a123")
  end
end