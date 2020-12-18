class Invoice < ApplicationRecord
  belongs_to :customer
  belongs_to :merchant

  has_many :invoice_items
  has_many :items, through: :invoice_items

  has_many :transactions

  def self.revenue_across_dates(start_date, end_date)
    start = Date.parse(start_date).beginning_of_day.to_s[0..-5]
    ending = Date.parse(end_date).end_of_day.to_s[0..-5]

    self.select("SUM(invoice_items.unit_price * invoice_items.quantity) AS revenue")
    .joins(:invoice_items, :transactions)
    .where(transactions: {result: "success"})
    .where(invoices: {status: "shipped"})
    .where(created_at: start..ending)[0]
  end
end
