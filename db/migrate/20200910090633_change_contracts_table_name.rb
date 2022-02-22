class ChangeContractsTableName < ActiveRecord::Migration[6.0]
  def change
    rename_table :contracts, :client_projects
    rename_column :freelancer_projects, :contract_id, :client_project_id
    rename_column :invoices, :contract_id, :client_project_id
  end
end
