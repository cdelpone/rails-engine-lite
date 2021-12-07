require 'rails_helper'

RSpec.describe Customer, type: :model do
  it 'exists' do
    customer1 = Customer.new
    expect(customer1).to be_a Customer
  end
end
