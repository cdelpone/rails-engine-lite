require 'rails_helper'
# rspec spec/models/item_spec.rb
RSpec.describe Item, type: :model do
  describe 'relationships' do
    it { should belong_to(:merchant) }

    it { should have_many(:invoice_items) }
  end
end
