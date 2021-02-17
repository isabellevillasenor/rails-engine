class Merchant < ApplicationRecord
  validates_presence_of :name
  has_many :items

  scope :search_all_by_name, ->(search) {where 'name LIKE :search', search: "%#{search.downcase}%"}
end
