require 'rails_helper'
# rspec spec/models/item_spec.rb
RSpec.describe Item, type: :model do
  describe 'relationships' do
    it { should belong_to(:merchant) }

    it { should have_many(:invoice_items) }

    it { should validate_presence_of :name }
  end

  describe 'class methods/scopes' do
    context 'happy paths' do
      it 'Finds all items by name fragment, fetch all items matching a pattern' do
        merchant1 = create(:merchant)
        item1 = create :item, { name: "this item has a name", merchant_id: merchant1.id }
        item2 = create :item, { name: "The BEST name", merchant_id: merchant1.id }
        item3 = create :item, { name: "The second-best name", merchant_id: merchant1.id }
        item4 = create :item, { name: "The bestest name", merchant_id: merchant1.id }
        item5 = create :item, { name: "The worst name", merchant_id: merchant1.id }

        search_name = "best"

        expect(Item.search_by_name(search_name)).to eq([item2, item4, item3])
        expect(Item.search_by_name(search_name).count).to eq(3)
      end
    end

    context 'sad paths' do
      it 'Finds all items by name fragment, no fragment matched' do
        merchant1 = create(:merchant)
        item1 = create :item, { name: "Best name", merchant_id: merchant1.id }
        item2 = create :item, { name: "The BEST name", merchant_id: merchant1.id }
        item3 = create :item, { name: "The second-best name", merchant_id: merchant1.id }
        item4 = create :item, { name: "The bestest name", merchant_id: merchant1.id }

        search_name = "worst"

        expect(Item.search_by_name(search_name)).to eq([])
      end
    end

    context 'edge cases' do
      it 'not case sensitive' do
        merchant1 = create(:merchant)
        item1 = create :item, { name: "The BEST name", merchant_id: merchant1.id }
        item2 = create :item, { name: "The second-best name", merchant_id: merchant1.id }
        item3 = create :item, { name: "bestest name", merchant_id: merchant1.id }

        search_name = "BeST"

        expect(Item.search_by_name(search_name)).to eq([item1, item2, item3])
        expect(Item.search_by_name(search_name).count).to eq(3)
      end

      it 'edge case, not character sensitive' do
        merchant1 = create(:merchant)
        item1 = create :item, { name: "The BEST name", merchant_id: merchant1.id }
        item2 = create :item, { name: "The second-best name", merchant_id: merchant1.id }
        item3 = create :item, { name: "The bestest name", merchant_id: merchant1.id }

        search_name = "best"

        expect(Item.search_by_name(search_name)).to eq([item1, item3, item2])
        expect(Item.search_by_name(search_name).count).to eq(3)
      end

      it 'edge case, finds fragments' do
        merchant1 = create(:merchant)
        item1 = create :item, { name: "The BEST name", merchant_id: merchant1.id }
        item2 = create :item, { name: "The second-best name", merchant_id: merchant1.id }
        item3 = create :item, { name: "The bestest name", merchant_id: merchant1.id }

        search_name = "est"

        expect(Item.search_by_name(search_name)).to eq([item1, item3, item2])
        expect(Item.search_by_name(search_name).count).to eq(3)
      end
    end
  end
end
