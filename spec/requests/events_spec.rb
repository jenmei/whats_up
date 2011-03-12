require 'spec_helper'

describe "Events" do
  describe "GET /events" do
    before do
      visit '/events'
    end

    it "should show title" do
      within('h1') do
        page.should have_content("Listing events")
      end
    end

  end
  
  describe "GET /events/pull_events" do
    it "pulls events" do
      visit("/events")
      click_on 'Fetch'
      page.should have_content("Events fetched")
      current_path.should == "/events"
    end
  end
end
