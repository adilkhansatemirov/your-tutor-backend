class RemoveFreelancerTypeOfBilling < ActiveRecord::Migration[6.0]
  def change
    remove_column :projects, :freelancer_type_of_billing, :integer
  end
end
