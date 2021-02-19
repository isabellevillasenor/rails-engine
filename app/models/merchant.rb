class Merchant < ApplicationRecord
  validates_presence_of :name
  has_many :items
  has_many :invoices

  scope :search_all_by_name, ->(search) {where 'name LIKE :search', search: "%#{search.downcase}%"}
  scope :search_one_by_name, ->(search) {find_by 'name LIKE :search', search: "%#{search.downcase}%"}

  def self.most_revenue(quantity)
    joins(invoices: [:invoice_items, :transactions])
    .where("invoices.status='shipped' AND transactions.result='success'")
    .select('merchants.*, SUM(invoice_items.quantity * invoice_items.unit_price) AS revenue')
    .group('merchants.id')
    .order('revenue DESC')
    .limit(quantity.to_i)
  end

  def self.most_items(quantity)
    joins(invoices: [:invoice_items, :transactions])
    .where("transactions.result='success'")
    .select('merchants.*, SUM(invoice_items.quantity) AS total')
    .group('merchants.id')
    .order('total DESC')
    .limit(quantity.to_i)
  end

  def self.revenue(start_date, end_date)
    joins(invoices: [:item_invoices, :transactions])
    .where("invoices.status='shipped' AND transactions.result='success'")
    .where('date(invoices.created_at) BETWEEN ? AND ?', start_date, end_date)
    .select('SUM(invoice_items.quantity * invoice_items.unit_price)')
  end
end
