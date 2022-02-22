class AddPublickIdToFreelancerDetail < ActiveRecord::Migration[6.0]
  def change
    add_column :freelancer_details, :public_id, :string
    add_column :freelancer_details, :file_format, :string
    add_column :freelancer_details, :pages, :integer
  end
end
