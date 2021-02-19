class Item < ApplicationRecord
  validates_presence_of :name,
                        :description
  validates :unit_price, numericality: { greater_than: 0 }
  belongs_to :merchant

  scope :search_all_by_name, ->(search) {where 'name LIKE :search', search: "%#{search.downcase}%"}
  scope :search_one_by_name, ->(search) {find_by 'name LIKE :search', search: "%#{search.downcase}%"}
end
