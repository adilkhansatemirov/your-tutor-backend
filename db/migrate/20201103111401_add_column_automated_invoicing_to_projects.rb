class AddColumnAutomatedInvoicingToProjects < ActiveRecord::Migration[6.0]
  def change
    add_column :projects, "automated_invoicing", :boolean, default: false
  end
end
