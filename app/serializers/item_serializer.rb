class ItemSerializer
  include JSONAPI::Serializer

  attributes :name, :description, :unit_price, :merchant_id

  def self.item_not_found
    { errors: { message:  "This item id does not exist"  }  }
  end
end
