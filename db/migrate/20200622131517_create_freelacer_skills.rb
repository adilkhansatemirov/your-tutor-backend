class CreateFreelacerSkills < ActiveRecord::Migration[6.0]
  def change
    create_table :freelacer_skills do |t|
      t.references :user, null: false, foreign_key: true
      t.references :skill, null: false, foreign_key: true

      t.timestamps
    end
  end
end
