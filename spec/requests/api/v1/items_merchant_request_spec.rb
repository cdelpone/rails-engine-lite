require 'rails_helper'
# ber spec/requests/api/v1/items_merchant_request_spec.rb
RSpec.describe 'Items Merchant API' do
  it 'sends the merchant for an item' do
    merchant1 = create :merchant
    merchant2 = create :merchant
    item1 = create :item, { merchant_id: merchant1.id }

    get "/api/v1/items/#{item1.id}/merchant"

    expect(response).to be_successful

    items_merch = JSON.parse(response.body, symbolize_names: true)

    expect(merchant1.items).to eq([item1])
    expect(merchant2.items).to eq([])
    expect(merchant2.items).to be_empty
    expect(items_merch).to have_key :data
    expect(items_merch[:data]).to have_key :id
    expect(items_merch[:data][:id].to_i).to eq(merchant1.id)
    expect(items_merch[:data]).to have_key :type
    expect(items_merch[:data][:type]).to eq("merchant")
    expect(items_merch[:data]).to have_key :attributes
    expect(items_merch[:data][:attributes]).to have_key :name
    expect(items_merch[:data][:attributes][:name]).to eq(merchant1.name)
  end

  it 'sad path, bad item id returns 404' do
    merchant1 = create :merchant
    item1 = create :item, { merchant_id: merchant1.id }
    invalid_id = item1.id + 1

    get "/api/v1/items/#{invalid_id}/merchant"

    parsed_response = JSON.parse(response.body, symbolize_names: true)

    expect(response).to_not be_successful
    expect(response.status).to eq(404)
    expect(parsed_response).to have_key :errors
    expect(parsed_response[:errors]).to have_key :message
    expect(parsed_response[:errors][:message]).to eq("This item id does not exist")
  end
end
