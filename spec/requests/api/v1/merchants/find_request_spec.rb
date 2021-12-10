require 'rails_helper'
# ber spec/requests/api/v1/merchants/find_request_spec.rb
RSpec.describe 'Find One Merchant API' do
  context 'happy paths' do
    it 'fetch one merchant by fragment' do
      merchant1 = create :merchant, { name: "this merchant has a name" }
      merchant2 = create :merchant, { name: "The best name" }
      merchant3 = create :merchant, { name: "The worst name" }

      search_name = "best"

      get "/api/v1/merchants/find?name=#{search_name}"

      expect(response).to be_successful

      found_merchant = JSON.parse(response.body, symbolize_names: true)

      expect(found_merchant).to have_key :data
      expect(found_merchant[:data].count).to eq(3)

      merchant_data = found_merchant[:data]

      expect(merchant_data).to have_key :id
      expect(merchant_data[:id]).to be_a String

      expect(merchant_data).to have_key :type
      expect(merchant_data[:type]).to be_a String
      expect(merchant_data[:type]).to eq("merchant")

      expect(merchant_data).to have_key :attributes
      expect(merchant_data[:attributes]).to be_a Hash

      expect(merchant_data[:attributes]).to have_key :name
      expect(merchant_data[:attributes][:name]).to be_a String
      expect(merchant_data[:attributes][:name]).to eq(merchant2.name)
    end
  end

  context 'sad paths' do
    it 'no fragment matched returns empty object' do
      merchant1 = create :merchant, { name: "this merchant has a name" }
      merchant2 = create :merchant, { name: "The best name" }
      merchant3 = create :merchant, { name: "The worst name" }

      search_name = "zzz"

      get "/api/v1/merchants/find?name=#{search_name}"

      expect(response).to be_successful
      expect(response.status).to eq(200)

      no_merch = JSON.parse(response.body, symbolize_names: true)

      expect(no_merch).to have_key :data
      expect(no_merch).to_not have_key :errors
    end
  end

  context 'edge cases' do
    it 'not case sensitive' do
      merchant1 = create :merchant, { name: "The BEST name" }
      merchant2 = create :merchant, { name: "The worst name" }

      search_name = "BeST"

      get "/api/v1/merchants/find?name=#{search_name}"

      expect(response).to be_successful

      found_merchant = JSON.parse(response.body, symbolize_names: true)

      expect(found_merchant).to have_key :data
      expect(found_merchant[:data].count).to eq(3)

      merchant_data = found_merchant[:data]

      expect(merchant_data).to have_key :id
      expect(merchant_data[:id]).to be_a String

      expect(merchant_data).to have_key :type
      expect(merchant_data[:type]).to be_a String
      expect(merchant_data[:type]).to eq("merchant")

      expect(merchant_data).to have_key :attributes
      expect(merchant_data[:attributes]).to be_a Hash

      expect(merchant_data[:attributes]).to have_key :name
      expect(merchant_data[:attributes][:name]).to be_a String
      expect(merchant_data[:attributes][:name]).to eq(merchant1.name)
      expect(merchant_data[:attributes][:name]).to_not eq(merchant2.name)
    end

    it 'not character sensitive' do
      merchant1 = create :merchant, { name: "The second-best!! name" }
      merchant2 = create :merchant, { name: "The worst name" }

      search_name = "best"

      get "/api/v1/merchants/find?name=#{search_name}"

      found_merchant = JSON.parse(response.body, symbolize_names: true)

      expect(found_merchant).to have_key :data
      expect(found_merchant[:data].count).to eq(3)

      merchant_data = found_merchant[:data]

      expect(merchant_data).to have_key :id
      expect(merchant_data[:id]).to be_a String

      expect(merchant_data).to have_key :type
      expect(merchant_data[:type]).to be_a String
      expect(merchant_data[:type]).to eq("merchant")

      expect(merchant_data).to have_key :attributes
      expect(merchant_data[:attributes]).to be_a Hash

      expect(merchant_data[:attributes]).to have_key :name
      expect(merchant_data[:attributes][:name]).to be_a String
      expect(merchant_data[:attributes][:name]).to eq(merchant1.name)
      expect(merchant_data[:attributes][:name]).to_not eq(merchant2.name)
    end

    it 'finds fragments' do
      merchant1 = create :merchant, { name: "this merchant has a name" }
      merchant2 = create :merchant, { name: "The best name" }
      merchant3 = create :merchant, { name: "The worst name" }

      search_name = "rst"

      get "/api/v1/merchants/find?name=#{search_name}"

      worst_merchant = JSON.parse(response.body, symbolize_names: true)

      expect(worst_merchant).to have_key :data
      expect(worst_merchant[:data].count).to eq(3)

      merchant_data = worst_merchant[:data]

      expect(merchant_data).to have_key :id
      expect(merchant_data[:id]).to be_a String

      expect(merchant_data).to have_key :type
      expect(merchant_data[:type]).to be_a String
      expect(merchant_data[:type]).to eq("merchant")

      expect(merchant_data).to have_key :attributes
      expect(merchant_data[:attributes]).to be_a Hash

      expect(merchant_data[:attributes]).to have_key :name
      expect(merchant_data[:attributes][:name]).to be_a String
      expect(merchant_data[:attributes][:name]).to eq(merchant3.name)
      expect(merchant_data[:attributes][:name]).to_not eq(merchant1.name)
      expect(merchant_data[:attributes][:name]).to_not eq(merchant2.name)
    end
  end

  context 'extensions - edge cases' do
    it 'edge case, no param given' do
      merchant1 = create :merchant, { name: "this merchant has a name" }

      get "/api/v1/merchants/find"

      expect(response).to_not be_successful
      expect(response.status).to eq(400)

      no_params = JSON.parse(response.body, symbolize_names: true)

      expect(no_params).to have_key :errors
      expect(no_params[:errors]).to have_key :message
      expect(no_params[:errors][:message]).to eq("Looks like something is missing")
    end

    it 'edge case, name fragment is empty' do
      merchant1 = create :merchant, { name: "this merchant has a name" }

      get "/api/v1/merchants/find?name="

      expect(response).to_not be_successful
      expect(response.status).to eq(400)

      no_params = JSON.parse(response.body, symbolize_names: true)

      expect(no_params).to have_key :errors
      expect(no_params[:errors]).to have_key :message
      expect(no_params[:errors][:message]).to eq("Looks like something is missing")
    end
  end
end
