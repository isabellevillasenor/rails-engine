class Item < ApplicationRecord
  validates_presence_of :name,
                        :description
  validates :unit_price, numericality: { greater_than: 0 }
  belongs_to :merchant

  scope :search_by_name, ->(search) {find_by 'name LIKE :search', search: "%#{search.downcase}%"}
end
