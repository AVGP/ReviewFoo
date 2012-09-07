require 'spec_helper'

describe "Repository index" do
  it "should have a link to create a new repository" do
    visit "/repositories/"
    click_link("New Repository")
    current_path.should == "/repositories/new"
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