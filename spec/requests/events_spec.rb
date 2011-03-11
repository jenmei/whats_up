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
end
