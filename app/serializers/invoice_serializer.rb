class InvoiceSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :status

  belongs_to :customer
  belongs_to :merchant

end
