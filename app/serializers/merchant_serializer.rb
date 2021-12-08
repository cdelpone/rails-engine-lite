class MerchantSerializer
  include JSONAPI::Serializer

  attributes :name

  def self.merch_not_found
    { errors: { message:  "This merchant id does not exist"  }  }
  end
end
