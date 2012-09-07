require 'spec_helper'

describe "Repository index" do
  it "should have a link to create a new repository" do
    visit "/repositories/"
    click_link("New Repository")
    current_path.should == "/repositories/new"
  end  
end