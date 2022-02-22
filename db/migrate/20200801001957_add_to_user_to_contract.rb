class AddToUserToContract < ActiveRecord::Migration[6.0]
  def change
    remove_column :contracts, :client_id, :bigint
    add_reference :contracts, :user, foreign_key: true
  end
end
