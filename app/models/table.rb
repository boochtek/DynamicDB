class Table < ActiveRecord::Base
  belongs_to :database

  has_many :columns
end
