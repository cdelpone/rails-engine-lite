class Merchant < ApplicationRecord
  has_many :invoices
  has_many :items, dependent: :destroy
  validates_presence_of :name

  def self.search_by_name(name)
      where("name ilike ?", "%#{name}%")
     .order(name: :asc)
     .first
   end
end
