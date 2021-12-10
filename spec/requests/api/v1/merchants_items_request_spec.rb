require 'rails_helper'
# ber spec/requests/api/v1/merchants_items_request_spec.rb
RSpec.describe 'Merchants Items API' do
  it 'sends a list of a single merchants items' do
    merchant1 = create :merchant
    merchant2 = create :merchant
    item1 = create :item, { merchant_id: merchant1.id }
    item2 = create :item, { merchant_id: merchant1.id }
    item3 = create :item, { merchant_id: merchant2.id }

    get "/api/v1/merchants/#{merchant1.id}/items"

    expect(response).to be_successful

    result = JSON.parse(response.body, symbolize_names: true)

    expect(result).to have_key :data
    expect(result[:data].count).to eq(2)
    expect(result[:data].count).to eq(merchant1.items.count)

    merch_items = result[:data]

    expect(merch_items.count).to eq(2)
    expect(merch_items).to be_an Array

    merch_items.each do |item|
      expect(item).to have_key :id
      expect(item).to have_key :type
      expect(item[:type]).to eq("item")

      expect(item).to have_key :attributes
      expect(item[:attributes]).to be_a Hash
      expect(item[:attributes]).to have_key :name
      expect(item[:attributes]).to have_key :description
      expect(item[:attributes]).to have_key :unit_price
      expect(item[:attributes]).to have_key :merchant_id
      expect(item[:attributes][:merchant_id]).to eq(merchant1.id)
      expect(item[:attributes][:merchant_id]).to_not eq(merchant2.id)
    end
  end

  describe 'sad path & edge cases' do
    it 'sad path, bad integer merchant id returns 404' do
      merchant = create :merchant
      invalid_id = merchant.id + 1

      get "/api/v1/merchants/#{invalid_id}/items"

      parsed_response = JSON.parse(response.body, symbolize_names: true)

      expect(response).to_not be_successful
      expect(response.status).to eq(404)
      expect(parsed_response).to have_key :error
      expect(parsed_response[:error]).to have_key :message
      expect(parsed_response[:error][:message]).to eq("This merchant id does not exist")
    end

    it 'sad path, returns 404 if merchant is not found' do
      merchant1 = create :merchant
      item1 = create :item, { merchant_id: merchant1.id }

      get "/api/v1/merchants/2/items"

      error_response = JSON.parse(response.body, symbolize_names: true)

      expect(response).to_not be_successful
      expect(response.status).to eq(404)
      expect(error_response).to have_key :error
      expect(error_response[:error]).to have_key :message
      expect(error_response[:error][:message]).to eq("This merchant id does not exist")
    end
  end
end
