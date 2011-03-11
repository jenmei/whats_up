require 'spec_helper'

describe "tweets/show.html.erb" do
  before(:each) do
    @tweet = assign(:tweet, stub_model(Tweet,
      :content => "MyText",
      :author => "Author",
      :url => "Url"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/MyText/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Author/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Url/)
  end
end
