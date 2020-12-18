class Merchant < ApplicationRecord
  validates_presence_of :name

  has_many :items
  has_many :invoices
  has_many :customers, through: :invoices

  def self.most_revenue(quantity = 1)
    Merchant.select("merchants.*, SUM(invoice_items.unit_price * invoice_items.quantity) AS revenue")
    .joins(invoices: [:invoice_items, :transactions])
    .where(transactions: {result: "success"})
    .where(invoices: {status: "shipped"})
    .group(:id)
    .order("revenue DESC")
    .limit(quantity)
  end

  def self.most_items(quantity = 1)
    Merchant.select("merchants.*, SUM(invoice_items.quantity) AS total_quantity")
    .joins(invoices: [:invoice_items, :transactions])
    .where(transactions: {result: "success"})
    .where(invoices: {status: "shipped"})
    .group(:id)
    .order("total_quantity DESC")
    .limit(quantity)
  end

  def self.revenue_across_dates(start_date, end_date)
    start = Date.parse(start_date).beginning_of_day.to_s[0..-5]
    ending = Date.parse(end_date).end_of_day.to_s[0..-5]

    Invoice.select("SUM(invoice_items.unit_price * invoice_items.quantity) AS revenue")
    .joins(:invoice_items, :transactions)
    .where(transactions: {result: "success"})
    .where(invoices: {status: "shipped"})
    .where(created_at: start..ending)[0]
  end

  def revenue
    invoices.select("SUM(invoice_items.unit_price * invoice_items.quantity) AS revenue")
    .joins(:invoice_items, :transactions)
    .where(status: "shipped")
    .where("transactions.result = ?", "success")
    .group(:merchant_id)[0]
  end
end
