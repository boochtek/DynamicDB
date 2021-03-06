require 'spec_helper'

describe "tables/edit" do
  before(:each) do
    @table = assign(:table, stub_model(Table,
      :name => "MyString",
      :database_id => 1
    ))
  end

  it "renders the edit table form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", table_path(@table), "post" do
      assert_select "input#table_name[name=?]", "table[name]"
      assert_select "input#table_database_id[name=?]", "table[database_id]"
    end
  end
end
