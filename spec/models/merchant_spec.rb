require 'rails_helper'
# rspec spec/models/merchant_spec.rb
RSpec.describe Merchant, type: :model do
  describe 'relationships' do
    it { should have_many :invoices }
    it { should have_many :items }
  end
end
