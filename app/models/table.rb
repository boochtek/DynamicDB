class Table < ActiveRecord::Base
  belongs_to :database

  has_many :columns

  def name
    read_attribute(:name) || 'New Table'
  end
end
