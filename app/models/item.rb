class Item < ApplicationRecord
  belongs_to :merchant

  has_many :invoice_items

  validates_presence_of :name

  scope :search_by_name, ->(name) { where("name ilike ?", "%#{name}%").order(name: :asc) }
end
