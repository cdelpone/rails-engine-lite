require 'rails_helper'
# rspec spec/models/merchant_spec.rb
RSpec.describe Merchant, type: :model do
  describe 'relationships' do
    it { should have_many :invoices }
    it { should have_many :items }

    it { should validate_presence_of :name }
  end

  describe 'class methods/scopes' do
    context 'Find One merchant by Name Fragment' do
      it 'happy path, fetch one merchant by fragment' do
        merchant1 = create :merchant, { name: "this merchant has a name" }
        merchant2 = create :merchant, { name: "The best name" }
        merchant3 = create :merchant, { name: "The worst name" }

        search_name = "best"

        expect(Merchant.search_by_name(search_name)).to eq(merchant2)
        expect(Merchant.search_by_name(search_name)).to_not eq(merchant1)
        expect(Merchant.search_by_name(search_name)).to_not eq(merchant3)
      end

      it 'sad path, no fragment matched' do
        merchant1 = create :merchant, { name: "Best name" }
        merchant2 = create :merchant, { name: "The BEST name" }
        merchant3 = create :merchant, { name: "The second-best name" }

        search_name = "worst"

        expect(Merchant.search_by_name(search_name)).to eq(nil)
      end

      it 'edge case, not case sensitive' do
        merchant1 = create :merchant, { name: "The BEST name" }
        merchant2 = create :merchant, { name: "The worst name" }
        merchant3 = create :merchant, { name: "best name" }

        search_name = "BeST"

        expect(Merchant.search_by_name(search_name)).to eq(merchant1)
        expect(Merchant.search_by_name(search_name)).to_not eq(merchant2)
        expect(Merchant.search_by_name(search_name)).to_not eq(merchant3)
      end

      it 'edge case, not character sensitive' do
        merchant1 = create :merchant, { name: "The worst name" }
        merchant2 = create :merchant, { name: "The second-best name" }

        search_name = "best"

        expect(Merchant.search_by_name(search_name)).to eq(merchant2)
        expect(Merchant.search_by_name(search_name)).to_not eq(merchant1)
      end

      it 'edge case, finds fragments' do
        merchant1 = create :merchant, { name: "this merchant has a name" }
        merchant2 = create :merchant, { name: "The best name" }
        merchant3 = create :merchant, { name: "The worst name" }

        search_name = "est"

        expect(Merchant.search_by_name(search_name)).to eq(merchant2)
        expect(Merchant.search_by_name(search_name)).to_not eq(merchant1)
      end
    end
  end
end
