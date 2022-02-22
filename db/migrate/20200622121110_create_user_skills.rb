class CreateUserSkills < ActiveRecord::Migration[6.0]
  def change
    create_table :skills do |t|
      t.string :category
      t.string :sub_category
      t.string :skill
      t.boolean :enable, :default => true

      t.timestamps
    end
  end
end
