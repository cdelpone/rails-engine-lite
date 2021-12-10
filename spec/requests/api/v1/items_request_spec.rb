require 'rails_helper'
# ber spec/requests/api/v1/items_request_spec.rb
RSpec.describe 'Items API' do
  it 'sends a list of items' do
    merchant = create :merchant
    item1 = create :item, { merchant_id: merchant.id }
    item2 = create :item, { merchant_id: merchant.id }
    get '/api/v1/items'

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

  it 'sends one item' do
    merchant = create :merchant
    item1 = create :item, { merchant_id: merchant.id }
    item2 = create :item, { merchant_id: merchant.id }

    get "/api/v1/items/#{item1.id}"

    expect(response).to be_successful

    result = JSON.parse(response.body, symbolize_names: true)

    expect(result).to have_key :data
    expect(result[:data].count).to eq(3)

    item_data = result[:data]

    expect(item_data).to have_key :id
    expect(item_data[:id]).to be_a String

    expect(item_data).to have_key :type
    expect(item_data[:type]).to be_a String
    expect(item_data[:type]).to eq("item")

    expect(item_data).to have_key :attributes
    expect(item_data[:attributes]).to be_a Hash

    item_attributes = item_data[:attributes]

    expect(item_attributes).to have_key :name
    expect(item_attributes).to have_key :description
    expect(item_attributes).to have_key :unit_price

    expect(item_attributes[:name]).to be_a String
    expect(item_attributes[:name]).to eq(item1.name)

    expect(item_attributes[:description]).to be_a String
    expect(item_attributes[:description]).to eq(item1.description)

    expect(item_attributes[:unit_price]).to be_a Float
    expect(item_attributes[:unit_price]).to eq(item1.unit_price)
  end

  it 'creates an item' do
    merchant = create :merchant
    item_params = {
                    name: "best item",
                    description: "world's best time for sure",
                    unit_price: 10.25,
                    merchant_id: merchant.id
                  }
    headers = { "CONTENT_TYPE" => "application/json" }

    post "/api/v1/items", headers: headers, params: JSON.generate(item: item_params)

    new_item = Item.last

    expect(response).to be_successful
    expect(response.status).to eq(201)

    expect(new_item.name).to eq(item_params[:name])
    expect(new_item.description).to eq(item_params[:description])
    expect(new_item.unit_price).to eq(item_params[:unit_price])
    expect(new_item.merchant_id).to eq(item_params[:merchant_id])
  end

  it 'updates an item' do
    id = create(:item).id
    previous_item = Item.last.name
    item_params = { name: "worst item" }
    headers = {"CONTENT_TYPE" => "application/json"}

    patch "/api/v1/items/#{id}", headers: headers, params: JSON.generate({item: item_params})

    updated_item = Item.find_by(id: id)

    expect(response).to be_successful
    expect(updated_item.name).to_not eq(previous_item)
    expect(updated_item.name).to eq("worst item")
  end

  it "can delete an item" do
    merchant = create :merchant
    item = create :item, { merchant_id: merchant.id }

    expect(Item.count).to eq(1)

    delete "/api/v1/items/#{item.id}"

    expect(response).to be_successful
    expect(Item.count).to eq(0)
    expect(response.status).to eq(204)
  end

  it 'sad path, bad integer id returns 404' do
    merchant = create :merchant
    item = create :item, { merchant_id: merchant.id }
    invalid_id = item.id + 1

    get "/api/v1/items/#{invalid_id}"

    parsed_response = JSON.parse(response.body, symbolize_names: true)

    expect(response).to_not be_successful
    expect(response.status).to eq(404)
    expect(parsed_response).to have_key :errors
    expect(parsed_response[:errors]).to have_key :message
    expect(parsed_response[:errors][:message]).to eq("This item id does not exist")
  end

  # it 'edge case, when updating an item, bad merchant id returns 400 or 404' do
  #   merchant = create :merchant
  #   id = create(:item).id
  #   previous_item = create :item, { merchant_id: merchant.id }
  #   previous_item = Item.last.name
  #
  #   item_params = { name: "worst item", merchant_id: "sfj" }
  #   headers = {"CONTENT_TYPE" => "application/json"}
  #
  #   patch "/api/v1/items/#{id}", headers: headers, params: JSON.generate({item: item_params})
  #
  #   updated_item = Item.find_by(id: id)
  #   expect(updated_item.name).to_not eq(previous_item)
  #   expect(updated_item.name).to eq("worst item")
  #
  #   parsed_response = JSON.parse(response.body, symbolize_names: true)
  #
  #   expect(response).to_not be_successful
  #   expect(response.status).to eq(404)
  #   expect(parsed_response).to have_key :errors
  #   expect(parsed_response[:errors]).to have_key :message
  #   expect(parsed_response[:errors][:message]).to eq("This item id does not exist")
  # end
end
