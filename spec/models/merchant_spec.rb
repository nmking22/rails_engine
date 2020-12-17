require 'rails_helper'

describe Merchant, type: :model do
  describe 'validations' do
    it { should validate_presence_of :name}
  end

  describe "relationships" do
    it {should have_many :items}
    it {should have_many :invoices}
    it {should have_many(:customers).through(:invoices)}
  end

  describe 'class methods' do
    before :each do
      @merchant_1 = Merchant.create(name: "Bob's Burgers")
      @merchant_2 = Merchant.create(name: "Jimmy Pesto's Pizzeria")
      @merchant_3 = Merchant.create(name: 'A Taco Truck')
      @item_1 = Item.create(
        name: 'Burger',
        description: 'Good',
        unit_price: 5.00,
        merchant: @merchant_1
      )
      @item_2 = Item.create(
        name: 'Pizza',
        description: 'Evil',
        unit_price: 10.00,
        merchant: @merchant_2
      )
      @item_3 = Item.create(
        name: 'Taco',
        description: 'Overpriced',
        unit_price: 50.00,
        merchant: @merchant_3
      )
      @customer = Customer.create(
        first_name: 'John Michael',
        last_name: 'Vincent'
      )
      @invoice_1 = Invoice.create(
        customer: @customer,
        merchant: @merchant_1,
        status: 'shipped'
      )
      @invoice_2 = Invoice.create(
        customer: @customer,
        merchant: @merchant_2,
        status: 'shipped'
      )
      @invoice_3 = Invoice.create(
        customer: @customer,
        merchant: @merchant_3,
        status: 'packaged'
      )
      @invoice_4 = Invoice.create(
        customer: @customer,
        merchant: @merchant_3,
        status: 'shipped'
      )
      @invoice_item_1 = InvoiceItem.create(
        item: @item_1,
        invoice: @invoice_1,
        quantity: 500,
        unit_price: 5.00
      )
      @invoice_item_2 = InvoiceItem.create(
        item: @item_2,
        invoice: @invoice_2,
        quantity: 50,
        unit_price: 10.00
      )
      @invoice_item_3 = InvoiceItem.create(
        item: @item_3,
        invoice: @invoice_3,
        quantity: 99999,
        unit_price: 50.00
      )
      @invoice_item_4 = InvoiceItem.create(
        item: @item_3,
        invoice: @invoice_4,
        quantity: 99999,
        unit_price: 50.00
      )
      @transaction_1 = Transaction.create(
        invoice: @invoice_1,
        credit_card_number: 12345,
        credit_card_expiration_date: 04/23,
        result: 'success'
      )
      @transaction_2 = Transaction.create(
        invoice: @invoice_2,
        credit_card_number: 12345,
        credit_card_expiration_date: 04/23,
        result: 'success'
      )
      @transaction_3 = Transaction.create(
        invoice: @invoice_3,
        credit_card_number: 12345,
        credit_card_expiration_date: 04/23,
        result: 'success'
      )
      @transaction_4 = Transaction.create(
        invoice: @invoice_4,
        credit_card_number: 12345,
        credit_card_expiration_date: 04/23,
        result: 'failed'
      )
    end

    it '.most_revenue' do
      expect(Merchant.most_revenue(3)).to eq([@merchant_1, @merchant_2])
      expect(Merchant.most_revenue).to eq([@merchant_1])
    end

    it '.most_items' do
      expect(Merchant.most_revenue(3)).to eq([@merchant_1, @merchant_2])
      expect(Merchant.most_revenue).to eq([@merchant_1])
    end
  end
end
