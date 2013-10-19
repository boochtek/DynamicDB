require 'spec_helper'

describe "databases/show" do
  before(:each) do
    @database = assign(:database, stub_model(Database,
      :name => "Name"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
  end
end
