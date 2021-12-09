require 'rails_helper'
# ber spec/requests/api/v1/items/find_all_request_spec.rb
RSpec.describe 'Find All Items API' do
  it 'sends a list of items' do
    merchant = create :merchant
    item1 = create :item, { merchant_id: merchant.id }
    item2 = create :item, { merchant_id: merchant.id }
    get '/api/v1/items/find_all'

    expect(response).to be_successful

    items = JSON.parse(response.body, symbolize_names: true)

    expect(items).to have_key :data
    expect(items[:data].count).to eq(2)
    expect(items[:data]).to be_an Array

    items[:data].each do |item|
      expect(item).to have_key :id
      expect(item[:id]).to be_a String

      expect(item).to have_key :type
      expect(item[:type]).to be_a String

      expect(item).to have_key :attributes
      expect(item[:attributes]).to be_a Hash
      expect(item[:attributes]).to have_key :name
      expect(item[:attributes][:name]).to be_a String
      expect(item[:attributes]).to have_key :description
      expect(item[:attributes][:description]).to be_a String
      expect(item[:attributes]).to have_key :unit_price
      expect(item[:attributes][:unit_price]).to be_a Float
    end
  end
