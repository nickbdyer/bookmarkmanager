require 'spec_helper'

feature "User browses the list of links" do

  before(:each) { 
    Link.create(:url => "http://www.makesacademy.com", 
                :title => "Makers Academy")
  }

  scenario "when opening the home page" do
    visit '/'
    expect(page).to have_content("Makers Academy")
  end
end
