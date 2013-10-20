class Table < ActiveRecord::Base
  belongs_to :database

  has_many :columns
  has_many :records

  # attribute :name, String
  # timestamps

  default_scope order('created_at')

  def initialize(*args)
    super
    (1..5).each do |i|
      columns.build(name: "Column #{i}")
    end
    (1..4).each do |i|
      records.build
    end
  end

  def name
    read_attribute(:name) || 'New Table'
  end
end
