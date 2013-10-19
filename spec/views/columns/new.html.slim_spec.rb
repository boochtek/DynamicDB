require 'spec_helper'

describe "columns/new" do
  before(:each) do
    assign(:column, stub_model(Column,
      :name => "MyString",
      :table_id => 1
    ).as_new_record)
  end

  it "renders new column form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", columns_path, "post" do
      assert_select "input#column_name[name=?]", "column[name]"
      assert_select "input#column_table_id[name=?]", "column[table_id]"
    end
  end
end
