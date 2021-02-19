class TransactionSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :result

  belongs_to :invoice
end
