class InvoiceItem < ApplicationRecord
  belongs_to :invoice
  belongs_to :time_entry, optional: true
end
