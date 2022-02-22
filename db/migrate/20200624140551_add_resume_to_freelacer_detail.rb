class AddResumeToFreelacerDetail < ActiveRecord::Migration[6.0]
  def change
    add_column :freelacer_details, :resume_url, :string
  end
end
