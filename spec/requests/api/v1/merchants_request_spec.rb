require 'rails_helper'
# ber spec/requests/api/v1/merchants_request_spec.rb
RSpec.describe 'Merchants API' do
  it 'sends a list of merchants' do
    create_list :merchant, 4

    get '/api/v1/merchants'

    expect(response).to be_successful

    merchants = JSON.parse(response.body, symbolize_names: true)

    expect(merchants).to have_key :data
    expect(merchants[:data].count).to eq(4)
    expect(merchants[:data]).to be_an Array

    merchants[:data].each do |merchant|
      expect(merchant).to have_key :id
      expect(merchant[:id]).to be_a String

      expect(merchant).to have_key :type
      expect(merchant[:type]).to be_a String

      expect(merchant).to have_key :attributes
      expect(merchant[:attributes]).to be_a Hash
      expect(merchant[:attributes]).to have_key :name
      expect(merchant[:attributes][:name]).to be_a String
    end
  end

  it 'sends one merchant' do
    merchant = create :merchant

    get "/api/v1/merchants/#{merchant.id}"

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

  describe 'sad path & edge cases' do
    xit 'doesnt send unnecessary info' do
    end
    xit 'sad path, bad integer id returns 404' do
    end
  end
end
