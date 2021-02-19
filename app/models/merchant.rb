class Merchant < ApplicationRecord
  validates_presence_of :name
  has_many :items
  has_many :invoices

  scope :search_all_by_name, ->(search) {where 'name LIKE :search', search: "%#{search.downcase}%"}
  scope :search_one_by_name, ->(search) {find_by 'name LIKE :search', search: "%#{search.downcase}%"}
end
