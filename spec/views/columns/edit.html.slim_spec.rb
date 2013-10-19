require 'spec_helper'

describe "columns/edit" do
  before(:each) do
    @column = assign(:column, stub_model(Column,
      :name => "MyString",
      :table_id => 1
    ))
  end

  it "renders the edit column form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", column_path(@column), "post" do
      assert_select "input#column_name[name=?]", "column[name]"
      assert_select "input#column_table_id[name=?]", "column[table_id]"
    end
  end
end
