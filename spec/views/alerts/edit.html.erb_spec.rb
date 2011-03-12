require 'spec_helper'

describe "alerts/edit.html.erb" do
  before(:each) do
    @alert = assign(:alert, stub_model(Alert,
      :title => "MyString",
      :summary => "MyText"
    ))
  end

  it "renders the edit alert form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => alerts_path(@alert), :method => "post" do
      assert_select "input#alert_title", :name => "alert[title]"
      assert_select "textarea#alert_summary", :name => "alert[summary]"
    end
  end
end
