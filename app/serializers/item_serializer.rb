class ItemSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :name

  belongs_to :merchant
end
