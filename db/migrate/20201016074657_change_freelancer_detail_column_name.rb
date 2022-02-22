class ChangeFreelancerDetailColumnName < ActiveRecord::Migration[6.0]
  def change
    rename_column :freelancer_details, :quilified, :qualified
  end
end
