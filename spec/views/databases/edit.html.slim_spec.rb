require 'spec_helper'

describe "databases/edit" do
  before(:each) do
    @database = assign(:database, stub_model(Database,
      :name => "MyString"
    ))
  end

  it "renders the edit database form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", database_path(@database), "post" do
      assert_select "input#database_name[name=?]", "database[name]"
    end
  end
end
