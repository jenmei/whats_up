require 'spec_helper'

describe "homepage route" do
  it "should load" do
    visit "/"
    page.should have_content("Events") 
  end
end
