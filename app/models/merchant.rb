class Merchant < ApplicationRecord
  has_many :invoices
  has_many :items

  scope :search_by_name, ->(name) { where("name ilike ?", "%#{name}%").order(name: :asc).first }

end
