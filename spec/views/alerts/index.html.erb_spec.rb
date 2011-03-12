require 'spec_helper'

describe "alerts/index.html.erb" do
  before(:each) do
    assign(:alerts, [
      stub_model(Alert,
        :hash => 'ba2930d8f5addce9065c0af8a15a1f97',
        :title => "Floppy's Yoga Alert!",
        :summary => "It's awesome",
        :date => Time.at(1297798284)
      ),
      stub_model(Alert,
        :hash => 'ba292948f5addce9065c0af8a15a1f97',
        :title => "SC Tournament",
        :summary => "It's awesome",
        :date => Time.at(1297798284)
      )
    ])
  end

  it "renders a list of alerts" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Floppy's Yoga Alert!".to_s, :count => 1
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "It's awesome".to_s, :count => 2
  end
end
