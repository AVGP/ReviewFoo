require 'spec_helper'

describe "home page" do
  it "should show you the repository" do
    visit "/"
    page.should have_content "Repositories"
  end
end