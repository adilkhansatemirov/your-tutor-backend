module Admin::FreelancerSkillsService

  def self.create_multiple(items, user_id)
    freelancer_skills = []
    items.each do |item|
      freelancer_skills << FreelancerSkill.new(
        user_id: user_id,
        skill_id: item[:id],
      )
    end

    FreelancerSkill.import freelancer_skills, on_duplicate_key_update: { conflict_target: [:id],
                                                                         columns: [:skill_id, :user_id] }
  end

  def self.delete_multiple(items, user_id)
    FreelancerSkill.where(:skill_id => items.pluck(:id), user_id: user_id).destroy_all
  end

end
