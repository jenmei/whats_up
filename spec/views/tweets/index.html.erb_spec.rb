require 'spec_helper'

describe "tweets/index.html.erb" do
  before(:each) do
    assign(:tweets, [
      stub_model(Tweet,
        :content => "MyText",
        :author => "Author",
        :url => "Url"
      ),
      stub_model(Tweet,
        :content => "MyText",
        :author => "Author",
        :url => "Url"
      )
    ])
  end

  it "renders a list of tweets" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Author".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Url".to_s, :count => 2
  end
end
