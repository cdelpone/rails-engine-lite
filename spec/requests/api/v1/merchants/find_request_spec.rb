require 'rails_helper'
# ber spec/requests/api/v1/merchants/find_request_spec.rb
RSpec.describe 'Find One Merchant API' do
  it 'finds one merchant' do
    merchant = create :merchant
    query = "cool"
    get "/api/v1/merchants/?name=#{query}"

    expect(response).to be_successful

    result = JSON.parse(response.body, symbolize_names: true)

    expect(result).to have_key :data
    expect(result[:data].count).to eq(3)

    merchant_data = result[:data]

    expect(merchant_data).to have_key :id
    expect(merchant_data[:id]).to be_a String

    expect(merchant_data).to have_key :type
    expect(merchant_data[:type]).to be_a String
    expect(merchant_data[:type]).to eq("merchant")

    expect(merchant_data).to have_key :attributes
    expect(merchant_data[:attributes]).to be_a Hash

    expect(merchant_data[:attributes]).to have_key :name
    expect(merchant_data[:attributes][:name]).to be_a String
    expect(merchant_data[:attributes][:name]).to eq(merchant.name)
  end
end
