require 'rails_helper'
# rspec spec/models/customer_spec.rb
RSpec.describe Customer, type: :model do
  describe 'relationships' do
    it { should have_many :invoices }
  end
end
