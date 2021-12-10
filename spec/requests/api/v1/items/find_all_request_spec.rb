require 'rails_helper'
# ber spec/requests/api/v1/items/find_all_request_spec.rb
RSpec.describe 'Find All Items API' do
  context 'happy paths' do
    it 'Finds all items by name fragment, fetch all items matching a pattern' do
      merchant1 = create(:merchant)
      item1 = create :item, { name: "this item has a name", merchant_id: merchant1.id }
      item2 = create :item, { name: "The BEST name", merchant_id: merchant1.id }
      item3 = create :item, { name: "The second-best name", merchant_id: merchant1.id }
      item4 = create :item, { name: "The bestest name", merchant_id: merchant1.id }
      item5 = create :item, { name: "The worst name", merchant_id: merchant1.id }

      search_name = "best"

      get "/api/v1/items/find_all?name=#{search_name}"

      expect(response).to be_successful

      items = JSON.parse(response.body, symbolize_names: true)

      expect(items).to have_key :data
      expect(items[:data].count).to eq(3)
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
  end

  context 'sad paths' do
    it 'Finds all items by name fragment, no fragment matched' do
      merchant1 = create(:merchant)
      item1 = create :item, { name: "this item has a name", merchant_id: merchant1.id }
      item2 = create :item, { name: "The BEST name", merchant_id: merchant1.id }
      item3 = create :item, { name: "The worst name", merchant_id: merchant1.id }

      search_name = "zzz"

      get "/api/v1/items/find_all?name=#{search_name}"

      expect(response).to be_successful
      expect(response.status).to eq(200)

      no_items = JSON.parse(response.body, symbolize_names: true)

      expect(no_items).to have_key :data
      expect(no_items).to_not have_key :errors
      expect(no_items[:data]).to eq([])
    end
  end

  context 'edge cases' do
    it 'not case sensitive' do
      merchant1 = create(:merchant)
      item1 = create :item, { name: "The BEST name", merchant_id: merchant1.id }
      item2 = create :item, { name: "The best name", merchant_id: merchant1.id }

      search_name = "BeST"

      get "/api/v1/items/find_all?name=#{search_name}"

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

    it 'not character sensitive' do
      merchant1 = create(:merchant)
      item1 = create :item, { name: "The BEST name", merchant_id: merchant1.id }
      item2 = create :item, { name: "The second-best name", merchant_id: merchant1.id }
      item3 = create :item, { name: "!best! name", merchant_id: merchant1.id }

      search_name = "best"

      get "/api/v1/items/find_all?name=#{search_name}"

      expect(response).to be_successful

      items = JSON.parse(response.body, symbolize_names: true)

      expect(items).to have_key :data
      expect(items[:data].count).to eq(3)
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

    it 'finds fragments' do
      merchant1 = create(:merchant)
      item1 = create :item, { name: "The BEST name", merchant_id: merchant1.id }
      item2 = create :item, { name: "The second-best name", merchant_id: merchant1.id }
      item3 = create :item, { name: "The bestest name", merchant_id: merchant1.id }
      item4 = create :item, { name: "The worst name", merchant_id: merchant1.id }

      search_name = "rst"

      get "/api/v1/items/find_all?name=#{search_name}"

      expect(response).to be_successful

      items = JSON.parse(response.body, symbolize_names: true)

      expect(items).to have_key :data
      expect(items[:data].count).to eq(1)
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
  end

  context 'extensions - edge cases' do
    it 'edge case, no param given' do
      merchant1 = create(:merchant)
      item1 = create :item, { name: "this item has a name", merchant_id: merchant1.id }

      get "/api/v1/items/find_all"

      expect(response).to_not be_successful
      expect(response.status).to eq(400)

      no_params = JSON.parse(response.body, symbolize_names: true)

      expect(no_params).to have_key :errors
      expect(no_params[:errors]).to have_key :message
      expect(no_params[:errors][:message]).to eq("Looks like something is missing")
    end

    it 'edge case, name fragment is empty' do
      merchant1 = create(:merchant)
      item1 = create :item, { name: "this item has a name", merchant_id: merchant1.id }

      get "/api/v1/items/find_all?name="

      expect(response).to_not be_successful
      expect(response.status).to eq(400)

      no_params = JSON.parse(response.body, symbolize_names: true)

      expect(no_params).to have_key :errors
      expect(no_params[:errors]).to have_key :message
      expect(no_params[:errors][:message]).to eq("Looks like something is missing")
    end
  end
end
