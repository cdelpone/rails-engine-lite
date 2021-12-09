require 'rails_helper'
# ber spec/requests/api/v1/items_merchants_request_spec.rb
RSpec.describe 'Items Merchants API' do
  it 'sends the merchant for a single item' do
    merchant1 = create :merchant
    merchant2 = create :merchant
    item1 = create :item, { merchant_id: merchant1.id }

    get "/api/v1/items/#{item1.id}/merchant"

    expect(response).to be_successful
    expect(merchant1.items).to eq([item1])
    expect(merchant2.items).to eq([])
    expect(merchant2.items).to be_empty
  end

  describe 'sad path & edge cases' do
    xit 'doesnt send unnecessary info' do
    end
    it 'sad path, bad integer id returns 404' do
    end
  end
end
  #
  # xit 'sends the merchant for a single item' do
  #   merchant1 = create :merchant
  #   merchant2 = create :merchant
  #   item1 = create :item, { merchant_id: merchant1.id }
  #
  #   get "/api/v1/items/#{item1.id}/merchants"
  #
  #   expect(response).to be_successful
  #   expect(merchant1.items).to eq([item1])
  #   expect(merchant2.items).to eq([])
  #   expect(merchant2.items).to be_empty
  # end
