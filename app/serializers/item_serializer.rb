class ItemSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :name, :description

  belongs_to :merchant
end
