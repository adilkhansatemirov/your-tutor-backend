module Admin::InvoiceItemsService

  def self.create_multiple(items, invoice_id)
    invoice_items = []
    items.each do |item|
      invoice_items << InvoiceItem.new(
        invoice_id: invoice_id,
        item: item[:item],
        qty: item[:qty],
        price: item[:price],
        time_entry_id: item[:time_entry_id],
      )
    end

    InvoiceItem.import invoice_items, on_duplicate_key_update: { conflict_target: [:id],
                                                                 columns: [:invoice_id, :item, :qty, :price, :time_entry_id] }
  end

  def self.update_multiple(items, invoice_id)
    invoice_items = []
    items.each do |item|
      invoice_items << InvoiceItem.new(
        id: item[:id],
        invoice_id: invoice_id,
        item: item[:item],
        qty: item[:qty],
        price: item[:price],
        time_entry_id: item[:time_entry_id],
      )
    end

    InvoiceItem.import invoice_items, on_duplicate_key_update: { conflict_target: [:id],
                                                                 columns: [:invoice_id, :item, :qty, :price, :time_entry_id] }
  end

  def self.delete_multiple(items)
    InvoiceItem.where(:id => items.pluck(:id)).destroy_all
  end

end
