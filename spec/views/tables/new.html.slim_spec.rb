require 'spec_helper'

describe "tables/new" do
  before(:each) do
    assign(:table, stub_model(Table,
      :name => "MyString",
      :database_id => 1
    ).as_new_record)
  end

  it "renders new table form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", tables_path, "post" do
      assert_select "input#table_name[name=?]", "table[name]"
      assert_select "input#table_database_id[name=?]", "table[database_id]"
    end
  end
end
